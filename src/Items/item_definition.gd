class_name ItemDefinition
extends Resource

@export var components: Array[ComponentDefinition]
@export var texture: AtlasTexture

func get_item() -> Item:
	return Item.new(self)
