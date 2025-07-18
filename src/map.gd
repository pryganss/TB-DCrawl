extends Node

var game_map: TileMapLayer
var entities: Node2D

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
