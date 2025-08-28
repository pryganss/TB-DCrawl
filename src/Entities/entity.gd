class_name Entity
extends Sprite2D

var tile_set: TileSet = preload("res://Assets/ts_32rogues.tres")
var components: Dictionary[int, Component]
var blocker: bool

var grid_position: Vector2i:
	set(value):
		grid_position = value
		position = value * tile_set.tile_size
		return value

func _init(entity_definition: EntityDefinition, start_pos: Vector2i):
	centered = false
	grid_position = start_pos
	texture = entity_definition.texture
	blocker = entity_definition.blocker

	for component in entity_definition.components:
		var new_component = component.get_component()
		components[new_component.TYPE] = new_component
		add_child(new_component)

func flash(color: Color):
	modulate = color
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
