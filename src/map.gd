extends Node

signal new_game_tick

const player_definition = preload("res://Assets/Entities/player_definition.tres")

const TILES: Dictionary[String, Vector2i] = {
	"FLOOR": Vector2i(0, 11),
	}
const MAP_SIZE = Vector2i(50, 50)

signal map_ready

var current_floor = 0

signal new_room(args: Dictionary, signal_name: String)

var remaining_rooms: int = 5:
	set(value):
		new_room.emit({}, "new_room")
		remaining_rooms = value

var last_room: MapLeaf

var game_map: TileMapLayer
var entities: Node
var player: Entity

var rooms: Array[MapLeaf]
var wall_tiles: Dictionary[Vector2i, Array]

var auto_tiles: Dictionary[Vector2i, int]

var astar: AStarGrid2D

func get_tile(grid_position: Vector2i) -> TileData:
	return game_map.get_cell_tile_data(grid_position)

func get_entities_at_tile(grid_position: Vector2i) -> Array[Entity]:
	var entities_at_tile: Array[Entity] = []
	for entity in entities.get_children() as Array[Entity]:
		if entity.grid_position == grid_position:
			entities_at_tile += [entity]
	return entities_at_tile

func erase_auto_tile(grid_position: Vector2i):
	auto_tiles.erase(grid_position)
	game_map.set_cells_terrain_connect([grid_position], 1, -1, false)
	update_auto_tiles()

func update_auto_tiles():
	game_map.set_cells_terrain_connect(auto_tiles.keys(), 1, 0, false)


func new_level():
	if player: entities.remove_child(player)
	get_tree().change_scene_to_file("res://src/game.tscn")

	await map_ready

	var game_manager = get_tree().current_scene as GameManager

	Initiative.reset()
	MapGen.generate_map()

	var starting_room: MapLeaf = rooms.pick_random()
	starting_room.room_placed.disconnect(MapGen.new_room)

	for door in starting_room.draw_room(game_map):
		entities.add_child(door)

	if player:
		player.grid_position = Vector2i(
			randi_range(starting_room.grid_position.x, starting_room.grid_position.x + starting_room.size.x - 2),
			randi_range(starting_room.grid_position.y, starting_room.grid_position.y + starting_room.size.y - 2))
	else:
		player = Entity.new(player_definition, Vector2i(
			randi_range(starting_room.grid_position.x, starting_room.grid_position.x + starting_room.size.x - 2),
			randi_range(starting_room.grid_position.y, starting_room.grid_position.y + starting_room.size.y - 2)))

	player.tree_entered.connect(game_manager.connect_player)

	Initiative.initiative[100] = player
	entities.add_child(player)

func win():
	Map.current_floor = 0
	get_tree().change_scene_to_file("res://src/UI/win.tscn")
