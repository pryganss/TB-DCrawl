class_name MapGen
extends Object

const player_definition = preload("res://Assets/Entities/player_definition.tres")

const MIN_ROOM_SIZE = Vector2i(6, 5)
const MAX_ROOM_SIZE = Vector2i(8, 7)

static func setup_pathfinding():
	Map.astar = AStarGrid2D.new()
	Map.astar.region = Rect2i(-1, -1, Map.MAP_SIZE.x + 1, Map.MAP_SIZE.y + 1)
	Map.astar.update()

func _init():
	assert(false)

static func generate_map():
	Map.auto_tiles = {}

	setup_pathfinding()

	var root_room = MapLeaf.new(Vector2i(), Map.MAP_SIZE)
	root_room.split(Map.remaining_rooms)
	Map.rooms = root_room.get_leaves()
	Map.wall_tiles = MapLeaf.get_wall_tiles(Map.rooms)
	MapLeaf.set_wall_tiles(Map.wall_tiles)
