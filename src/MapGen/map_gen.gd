class_name MapGen

const MAP_SIZE = Vector2i(50, 50)
const MIN_ROOM_SIZE = Vector2i(6, 5)
const MAX_ROOM_SIZE = Vector2i(8, 7)

const TILES: Dictionary[String, Vector2i] = {
	"WALL_TOP": Vector2i(1, 2),
	"WALL_SIDE": Vector2i(0, 2),
	"FLOOR": Vector2i(0, 11),
	}

static func draw_room(game_map: TileMapLayer, leaf: MapLeaf):
	for x in leaf.size.x + 2:
		game_map.set_cell(Vector2i(leaf.grid_position.x + x - 1, leaf.grid_position.y - 1), 0, TILES.WALL_TOP)
		game_map.set_cell(Vector2i(leaf.grid_position.x + x - 1, leaf.grid_position.y + leaf.size.y), 0, TILES.WALL_TOP)

		for y in leaf.size.y:
			game_map.set_cell(Vector2i(leaf.grid_position.x + x - 1, leaf.grid_position.y + y), 0, TILES.FLOOR)

	for y in leaf.size.y + 1:
		game_map.set_cell(Vector2i(leaf.grid_position.x - 1, leaf.grid_position.y + y - 1), 0, TILES.WALL_SIDE)
		game_map.set_cell(Vector2i(leaf.grid_position.x + leaf.size.x,  leaf.grid_position.y + y - 1), 0, TILES.WALL_SIDE)
