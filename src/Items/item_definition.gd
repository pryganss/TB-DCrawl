class_name ItemDefinition
extends Resource

@export var components: Array[ComponentDefinition]
@export var texture: AtlasTexture = preload("res://Assets/default_item.tres")

func get_item() -> Item:
	return Item.new(self)
