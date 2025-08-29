class_name MapGen
extends Object

const MIN_ROOM_SIZE = Vector2i(6, 5)
const MAX_ROOM_SIZE = Vector2i(8, 7)

const EXIT_ROOM: RoomDefinition = preload("res://Assets/MapGen/Rooms/exit_room.tres")
const map_definitions: Array[MapDefinition] = [
	preload("res://Assets/MapGen/floor_1.tres"),
	preload("res://Assets/MapGen/floor_2.tres"),
	]

static func setup_pathfinding():
	Map.astar = AStarGrid2D.new()
	Map.astar.region = Rect2i(-1, -1, Map.MAP_SIZE.x + 1, Map.MAP_SIZE.y + 1)
	Map.astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	Map.astar.update()

func _init():
	assert(false, "Tried to create instance of static class")

static func generate_map() -> void:
	Map.auto_tiles = {}

	Map.last_room = null

	setup_pathfinding()

	var root_room = MapLeaf.new(Vector2i(), Map.MAP_SIZE)
	root_room.split(5)
	Map.rooms = root_room.get_leaves()
	Map.wall_tiles = MapLeaf.get_wall_tiles(Map.rooms)
	MapLeaf.set_wall_tiles(Map.wall_tiles)

	Map.remaining_rooms = map_definitions[Map.current_floor].number_of_rooms

static func new_room(room: MapLeaf):
	var entities: Array[Entity] = []

	var room_entities: Array[EntityDefinition]
	if room == Map.last_room:
		room_entities = map_definitions[Map.current_floor].exit_room.features.duplicate()
	else:
		room_entities = map_definitions[Map.current_floor].room_types.pick_random().features.duplicate()
	var open_tiles: Array[Vector2i] = []

	for x in range(room.grid_position.x, room.grid_position.x + room.size.x - 1):
		for y in range(room.grid_position.y, room.grid_position.y + room.size.y - 1):
			open_tiles += [Vector2i(x, y)]

	while open_tiles && room_entities:
		var tile = open_tiles.pick_random()
		var entity = room_entities.pick_random()

		open_tiles.erase(tile)
		room_entities.erase(entity)

		entities += [Entity.new(entity, tile)]

	for entity in entities:
		Initiative.add_entity(entity)
