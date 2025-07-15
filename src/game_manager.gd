class_name GameManager
extends Node2D

const player_definition: EntityDefinition = preload("res://Assets/Entities/player_definition.tres")
@onready var player: Entity

@onready var entities: Node2D = $Entities
@onready var game_map: TileMapLayer = $Map
# @onready var event_handler: EventHandler = $EventHandler

var t: int = 0
var initiative: Dictionary[int, Entity]


func _ready():
	Map.game_map = game_map
	Map.entities = entities
	player = Entity.new(player_definition, Vector2i(5, 5))
	initiative[100] = player
	entities.add_child(player)

func _process(_delta):
	if get_current_turn() == player:
		var action: Action
		action = EventHandler.get_action()
		if action:
			initiative.erase(t)
			initiative[t + action.perform(player)] = player
			t += 1
	else:
		var entity = get_current_turn()
		initiative.erase(t)
		initiative[t + entity.do_turn()] = entity
		t += 1

func get_current_turn() -> Entity:
	var entity: Entity = null
	while not entity:
		entity = initiative.get(t)
		if not entity: t += 1

	return entity
