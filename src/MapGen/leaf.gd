class_name MapLeaf
extends RefCounted

const door_definition = preload("res://Assets/Entities/door_definition.tres")

var child_0: MapLeaf
var child_1: MapLeaf

var grid_position: Vector2i

var size: Vector2i

var walls: Dictionary[Vector2i, Array] = {}

var placed: bool = false
var has_door: bool = false

signal room_placed(room: MapLeaf)

func _init(position: Vector2i, room_size: Vector2i):
	grid_position = position
	size = room_size
	room_placed.connect(MapGen.new_room)

func get_leaves() -> Array[MapLeaf]:
	if not (child_0 and child_1):
		return [self]
	else:
		return child_0.get_leaves() + child_1.get_leaves()

static func set_wall_tiles(wall_tiles: Dictionary[Vector2i, Array]):
	for position in wall_tiles:
		for leaf in wall_tiles[position]:
			leaf.walls[position] = wall_tiles[position]

static func get_wall_tiles(rooms: Array[MapLeaf]) -> Dictionary[Vector2i, Array]:
	var wall_tiles: Dictionary[Vector2i, Array] = {}

	for leaf in rooms:
		var position = leaf.grid_position

		for x in range(position.x - 1,  position.x + leaf.size.x):
			var top = Vector2i(x, position.y - 1)
			var bottom = Vector2i(x, position.y + leaf.size.y - 1)
			wall_tiles[top] = wall_tiles.get(top, []) + [leaf]
			wall_tiles[bottom] = wall_tiles.get(bottom, []) + [leaf]

		for y in range(position.y, position.y + leaf.size.y - 1):
			var left = Vector2i(position.x - 1, y)
			var right = Vector2i(position.x + leaf.size.x - 1, y)
			wall_tiles[left] = wall_tiles.get(left, []) + [leaf]
			wall_tiles[right] = wall_tiles.get(right, []) + [leaf]

	return wall_tiles

func get_adjacent_rooms() -> Array[MapLeaf]:
	var rooms: Array[MapLeaf] = []
	for wall in walls:
		if walls[wall].size() > 1:
			for room in walls[wall]:
				if room != self and not rooms.has(room):
					rooms.append(room)
	return rooms

func split(remaining: int) -> void:
	var rng = RandomNumberGenerator.new()
	var split_ratio = rng.randf_range(0.25, 0.75)
	var split_across = size.y * rng.randf_range(0.6, 1.4) >= size.x * rng.randf_range(0.6, 1.4)

	if split_across and floori(size.y * 0.5) >= MapGen.MIN_ROOM_SIZE.y:
		var height =int(size.y * split_ratio)
		child_0 = MapLeaf.new(grid_position, Vector2i(size.x, height))
		child_1 = MapLeaf.new(
			Vector2i(grid_position.x, grid_position.y + height),
			Vector2i(size.x, size.y - height))
	elif not split_across and floori(size.x * 0.5) >= MapGen.MIN_ROOM_SIZE.x:
		var width = int(size.x * split_ratio)
		child_0 = MapLeaf.new(grid_position, Vector2i(width, size.y))
		child_1 = MapLeaf.new(
			Vector2i(grid_position.x + width, grid_position.y),
			Vector2i(size.x - width, size.y))

	else: return

	if remaining > 0:
		child_0.split(remaining - 1)
		child_1.split(remaining - 1)
	else:
		if child_0.size.length() > MapGen.MAX_ROOM_SIZE.length(): child_0.split(0)
		if child_1.size.length() > MapGen.MAX_ROOM_SIZE.length(): child_1.split(0)

func draw_room(game_map: TileMapLayer) -> Array[Entity]:
	var new_tiles: Array[Vector2i] = []
	for x in self.size.x + 1:
		new_tiles += [
			Vector2i(
				self.grid_position.x + x - 1,
				self.grid_position.y - 1),
			Vector2i(
				self.grid_position.x + x - 1,
				self.grid_position.y + self.size.y - 1)]

		if x <= self.size.x and x > 0:
			for y in self.size.y:
				game_map.set_cell(Vector2i(
					self.grid_position.x + x - 1,
					self.grid_position.y + y),
					0, Map.TILES.FLOOR)

	for y in self.size.y + 1:
		new_tiles += [
			Vector2i(
				self.grid_position.x - 1,
				self.grid_position.y + y - 1),
			Vector2i(
				self.grid_position.x + self.size.x - 1,
				self.grid_position.y + y - 1)
			]

		for tile in new_tiles:
			Map.auto_tiles[tile] = 1
			Map.astar.set_point_solid(tile)

		Map.update_auto_tiles()

	placed = true

	room_placed.emit(self)

	return get_random_doors()

func get_random_doors():
	var neighbors: Array[MapLeaf] = get_adjacent_rooms().filter(func(r: MapLeaf): return not r.placed and not r.has_door)

	var doors: Array[Entity] = []

	var valid_tiles := walls.keys().filter(func(t):
		var has_neighbor = false
		if neighbors.any(func(r): return walls[t].has(r)): has_neighbor = true
		return t.x > 0 and t.x < Map.MAP_SIZE.x - 1 and t.y > 0 and t.y < Map.MAP_SIZE.y - 1 and walls[t].size() < 3 and has_neighbor)

	while Map.remaining_rooms > 0 and neighbors.size() > 0 and valid_tiles.size() > 0:
		var tile = valid_tiles.pick_random()
		var current_room: MapLeaf

		neighbors = neighbors.filter(func(r): return not walls[tile].has(r))
		for room in walls[tile] as Array[MapLeaf]:
			if not room.has_door:
				current_room = room
				room.has_door = true
		valid_tiles = valid_tiles.filter(func(t):
			return neighbors.any(func(r): return walls[t].has(r)))

		doors += [Entity.new(door_definition, tile)]
		Map.remaining_rooms -= 1
		if Map.remaining_rooms == 0:
			Map.last_room = current_room

	return doors
