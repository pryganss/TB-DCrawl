extends Node

signal new_game_tick

const TILES: Dictionary[String, Vector2i] = {
	"FLOOR": Vector2i(0, 11),
	}
const MAP_SIZE = Vector2i(25, 25)

var remaining_rooms: int = 5

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

