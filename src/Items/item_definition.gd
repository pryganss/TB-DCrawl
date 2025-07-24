class_name ItemDefinition
extends Resource

@export var components: Array[ComponentDefinition]

func get_item() -> Item:
	return Item.new(self)
