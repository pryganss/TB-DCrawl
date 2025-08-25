class_name MapGen
extends Object

const map_definition = preload("res://Assets/MapGen/map_definition.tres")
const player_definition = preload("res://Assets/Entities/player_definition.tres")

const MIN_ROOM_SIZE = Vector2i(6, 5)
const MAX_ROOM_SIZE = Vector2i(8, 7)

static func setup_pathfinding():
	Map.astar = AStarGrid2D.new()
	Map.astar.region = Rect2i(-1, -1, Map.MAP_SIZE.x + 1, Map.MAP_SIZE.y + 1)
	Map.astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	Map.astar.update()

func _init():
	assert(false, "Tried to create instance of static class")

static func generate_map() -> Entity:
	Map.auto_tiles = {}

	setup_pathfinding()

	Map.remaining_rooms = 5

	var root_room = MapLeaf.new(Vector2i(), Map.MAP_SIZE)
	root_room.split(Map.remaining_rooms)
	Map.rooms = root_room.get_leaves()
	Map.wall_tiles = MapLeaf.get_wall_tiles(Map.rooms)
	MapLeaf.set_wall_tiles(Map.wall_tiles)

	var starting_room: MapLeaf = Map.rooms.pick_random()

	for door in starting_room.draw_room(Map.game_map):
		Map.entities.add_child(door)

	return Entity.new(player_definition, Vector2i(
		randi_range(starting_room.grid_position.x, starting_room.grid_position.x + starting_room.size.x - 2),
		randi_range(starting_room.grid_position.y, starting_room.grid_position.y + starting_room.size.y - 2)
		))

static func new_room(room: MapLeaf) -> Array[Entity]:
	var entities: Array[Entity] = []

	var room_entities: Array[EntityDefinition] = map_definition.room_types.pick_random().features.duplicate()
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

	return entities
