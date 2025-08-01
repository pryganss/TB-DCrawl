class_name ItemComponentDefinition
extends ComponentDefinition

@export var item_definition: ItemDefinition

func get_component() -> ItemComponent:
	return ItemComponent.new(self)
