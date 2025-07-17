class_name MapLeaf
extends RefCounted

var child_0: MapLeaf
var child_1: MapLeaf

var grid_position: Vector2i

var size: Vector2i

func _init(position: Vector2i, room_size: Vector2i):
	grid_position = position
	size = room_size

func get_leaves() -> Array[MapLeaf]:
	if not (child_0 and child_1):
		return [self]
	else:
		return child_0.get_leaves() + child_1.get_leaves()

func split(remaining: int) -> void:
	var rng = RandomNumberGenerator.new()
	var split_ratio = rng.randf_range(0.3, 0.7)
	var split_across = size.y >= size.x

	if split_across and floori(size.y * 0.5) >= MapGen.MIN_ROOM_SIZE.y:
		var height = max(int(size.y * split_ratio), MapGen.MIN_ROOM_SIZE.y)
		child_0 = MapLeaf.new(grid_position, Vector2i(size.x, height))
		child_1 = MapLeaf.new(
			Vector2i(grid_position.x, grid_position.y + height),
			Vector2i(size.x, size.y - height)
			)
	elif not split_across and floori(size.x * 0.5) >= MapGen.MIN_ROOM_SIZE.x:
		var width = max(int(size.x * split_ratio), MapGen.MIN_ROOM_SIZE.x)
		child_0 = MapLeaf.new(grid_position, Vector2i(width, size.y))
		child_1 = MapLeaf.new(
			Vector2i(grid_position.x + width, grid_position.y),
			Vector2i(size.x - width, size.y)
			)

	else: return

	if remaining > 0:
		child_0.split(remaining - 1)
		child_1.split(remaining - 1)
	else:
		if child_0.size.length() > MapGen.MAX_ROOM_SIZE.length(): child_0.split(0)
		if child_1.size.length() > MapGen.MAX_ROOM_SIZE.length(): child_1.split(0)
