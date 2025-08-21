class_name GameManager
extends Node2D

const player_definition: EntityDefinition = preload("res://Assets/Entities/player_definition.tres")
@onready var player: Entity

@onready var entities: Node = $Entities
@onready var game_map: TileMapLayer = $Map
@onready var event_handler: EventHandler = $EventHandler

var t: int = 0
var initiative: Dictionary[int, Entity]

signal turn_ended

func _ready():
	Map.game_map = game_map

	MapGen.generate_map()

	for door in Map.rooms[0].draw_room(Map.game_map):
		entities.add_child(door)

	Map.entities = entities
	player = Entity.new(player_definition, Vector2i(2, 2))
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


func reset(_entity: Entity):
	get_tree().change_scene_to_file("res://game.tscn")

func _process(_delta):
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
		if not entity: t += 1

	return entity

func pop_actor(entity: Entity):
	if initiative.find_key(entity): initiative.erase(initiative.find_key(entity))
	entity.queue_free()

func add_actor(entity: Entity):
	entities.add_child(entity)

	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	if fighter_component:
		fighter_component.died.connect(pop_actor)

	if not entity.components.get(cpnt.AI): return

	await turn_ended

	if not entity.is_queued_for_deletion():
		var first_turn = initiative.find_key(player) + 1
		while true:
			if initiative.get(first_turn):
				first_turn += 1
			else:
				initiative[first_turn] = entity
				break

func take_turn(action: Action, entity: Entity):
	var delay = action.perform()
	if delay != 0:
		delay_turn(entity, delay)
		t += 1
		turn_ended.emit()
	elif entity != player:
		delay_turn(entity, 100)
		t += 1
		turn_ended.emit()

func delay_turn(entity: Entity, delay: int):
	initiative.erase(t)
	while true:
		if initiative.get(t + delay):
			delay += 1
		else:
			initiative[t + delay] = entity
			break
