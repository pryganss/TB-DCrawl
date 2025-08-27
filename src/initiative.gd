extends Node

var t: int = 0
var initiative: Dictionary[int, Entity]

func get_current_turn() -> Entity:
	var entity: Entity = null
	while not entity:
		entity = initiative.get(t)
		if not entity:
			t += 1
			Map.new_game_tick.emit()

	entity.components.get(cpnt.FIGHTER).turn_started.emit()
	return entity

func pop_actor(entity: Entity):
	if initiative.find_key(entity): initiative.erase(initiative.find_key(entity))
	entity.queue_free()

func add_entity(entity: Entity):
	Map.entities.add_child(entity)

	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	if fighter_component:
		fighter_component.died.connect(pop_actor)

	if not entity.components.get(cpnt.AI): return

	await Map.player.components.get(cpnt.FIGHTER).turn_ended

	if not entity.is_queued_for_deletion():
		var first_turn = initiative.find_key(Map.player) + 1
		while true:
			if initiative.get(first_turn):
				first_turn += 1
			else:
				initiative[first_turn] = entity
				break

func take_turn(action: Action, entity: Entity):
	if action is WaitAction:
		pass_turn(entity)
		t += 1
		entity.components.get(cpnt.FIGHTER).turn_ended.emit()
	else:
		var delay = action.perform()
		if delay != 0:
			delay_turn(entity, delay)
			t += 1
			entity.components.get(cpnt.FIGHTER).turn_ended.emit()
			Map.new_game_tick.emit()
		elif entity != Map.player:
			assert(false, "AIComponent returned invalid action")

func delay_turn(entity: Entity, delay: int):
	initiative.erase(t)
	while true:
		if initiative.get(t + delay):
			delay += 1
		else:
			initiative[t + delay] = entity
			break

func pass_turn(entity):
	var keys = initiative.keys()
	keys.sort()
	if keys.size() > 1:
		var next_turn = keys[1]
		delay_turn(entity, next_turn - t)
	else:
		delay_turn(entity, 100)

func reset():
	t = 0
	initiative = {}
