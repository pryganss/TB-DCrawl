extends Node

var game_map: TileMapLayer
var entities: Node2D

var rooms: Array[MapLeaf]
var root_room: MapLeaf
var wall_tiles: Dictionary[Vector2i, Array]

var auto_tiles: Array[Vector2i]

func get_tile(grid_position: Vector2i) -> TileData:
	return game_map.get_cell_tile_data(grid_position)

func get_entity_at_tile(grid_position: Vector2i) -> Entity:
	for entity in entities.get_children() as Array[Entity]:
		if entity.grid_position == grid_position:
			return entity
	return null

func update_auto_tiles():
	game_map.set_cells_terrain_connect(auto_tiles, 1, 0, false)

func generate_map():
	root_room = MapLeaf.new(Vector2i(), MapGen.MAP_SIZE)
	rooms = root_room.get_leaves()
	wall_tiles = MapLeaf.get_wall_tiles(rooms)
