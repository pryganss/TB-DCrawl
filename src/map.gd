extends Node

const MAP_SIZE = Vector2i(25, 25)
const MIN_ROOM_SIZE = Vector2i(6, 5)
const MAX_ROOM_SIZE = Vector2i(8, 7)

const TILES: Dictionary[String, Vector2i] = {
	"FLOOR": Vector2i(0, 11),
	}

var remaining_rooms: int = 5

var game_map: TileMapLayer
var entities: Node
var player: Entity

var rooms: Array[MapLeaf]
var root_room: MapLeaf
var wall_tiles: Dictionary[Vector2i, Array]

var auto_tiles: Dictionary[Vector2i, int]

var astar: AStarGrid2D


func setup_pathfinding():
	astar = AStarGrid2D.new()
	astar.region = Rect2i(-1, -1, MAP_SIZE.x + 1, MAP_SIZE.y + 1)
	astar.update()

func get_tile(grid_position: Vector2i) -> TileData:
	return game_map.get_cell_tile_data(grid_position)

func get_entity_at_tile(grid_position: Vector2i) -> Entity:
	for entity in entities.get_children() as Array[Entity]:
		if entity.grid_position == grid_position:
			return entity
	return null

func erase_auto_tile(grid_position: Vector2i):
	auto_tiles.erase(grid_position)
	game_map.set_cells_terrain_connect([grid_position], 1, -1, false)
	update_auto_tiles()

func update_auto_tiles():
	game_map.set_cells_terrain_connect(auto_tiles.keys(), 1, 0, false)

func generate_map():
	auto_tiles = {}

	setup_pathfinding()

	root_room = MapLeaf.new(Vector2i(), MAP_SIZE)
	root_room.split(4)
	rooms = root_room.get_leaves()
	wall_tiles = MapLeaf.get_wall_tiles(rooms)
	MapLeaf.set_wall_tiles(wall_tiles)
