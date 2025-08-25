class_name GameManager
extends Node2D

@onready var player: Entity

@onready var entities: Node = $Entities
@onready var game_map: TileMapLayer = $Map
@onready var event_handler: EventHandler = $EventHandler

var t: int = 0
var initiative: Dictionary[int, Entity]

func _ready():
	Map.game_map = game_map
	Map.entities = entities
	Map.add_entity = Callable(self, "add_entity")

	player = MapGen.generate_map()
	initiative[100] = player
	event_handler.player = player
	Map.player = player
	entities.add_child(player)

	var plr_fighter_component: FighterComponent = player.components.get(cpnt.FIGHTER) as FighterComponent

	plr_fighter_component.died.connect(reset)
	plr_fighter_component.damaged.connect($UI.update_health)

	player.components.get(cpnt.WIELD).item_changed.connect($UI.update_item)

	$UI.update_health()
	$UI.update_item()

	$Camera2D.player = player


func reset(_entity: Entity):
	get_tree().change_scene_to_file("res://game.tscn")

func _physics_process(_delta):
	var entity = get_current_turn()
	if entity == player:
		var action: Action
		action = event_handler.get_action()
		if action:
			take_turn(action, player)
	elif entity:
		var action: Action = entity.components.get(cpnt.AI).get_action()
		take_turn(action, entity)

func get_current_turn() -> Entity:
	var entity: Entity = null
	while not entity:
		entity = initiative.get(t)
		if not entity:
			t += 1
			Map.new_game_tick.emit()

	return entity

func pop_actor(entity: Entity):
	if initiative.find_key(entity): initiative.erase(initiative.find_key(entity))
	entity.queue_free()

func add_entity(entity: Entity):
	entities.add_child(entity)

	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	if fighter_component:
		fighter_component.died.connect(pop_actor)

	if not entity.components.get(cpnt.AI): return

	await player.components.get(cpnt.FIGHTER).turn_ended

	if not entity.is_queued_for_deletion():
		var first_turn = initiative.find_key(player) + 1
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
		elif entity != player:
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
