class_name Entity
extends Sprite2D

var tile_set: TileSet = preload("res://Assets/ts_32rogues.tres")

var grid_position: Vector2i:
	set(value):
		grid_position = value
		position = value * tile_set.tile_size
		return value

func _init(entity_definition: EntityDefinition, start_pos: Vector2i):
	centered = false
	grid_position = start_pos
	texture = entity_definition.texture
