class_name GameManager
extends Node2D

const player_definition: EntityDefinition = preload("res://Assets/Entities/player_definition.tres")
const npc_definition: EntityDefinition = preload("res://Assets/Entities/npc_definition.tres")
@onready var player: Entity

@onready var entities: Node2D = $Entities
@onready var game_map: TileMapLayer = $Map
@onready var event_handler: EventHandler = $EventHandler

var t: int = 0
var initiative: Dictionary[int, Entity]


func _ready():
	Map.game_map = game_map
	var root_room = MapLeaf.new(Vector2i(0, 0), MapGen.MAP_SIZE)
	root_room.split(4)

	for room in root_room.get_leaves(): MapGen.draw_room(game_map, room)

	Map.entities = entities
	player = Entity.new(player_definition, Vector2i(2, 2))
	initiative[100] = player
	event_handler.player = player
	entities.add_child(player)
	entities.add_child(Entity.new(npc_definition, Vector2i(2, 3)))

func _process(_delta):
	var entity = get_current_turn()
	if entity == player:
		var action: Action
		action = event_handler.get_action()
		if action:
			var delay = action.perform()
			if delay:
				initiative.erase(t)
				initiative[t + delay] = player
				t += 1
	elif entity:
		pass
		# initiative.erase(t)
		# initiative[t + entity.do_turn()] = entity
		# t += 1

func get_current_turn() -> Entity:
	var entity: Entity = null
	while not entity:
		entity = initiative.get(t)
		if not entity: t += 1

	return entity
