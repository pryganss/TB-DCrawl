class_name WieldComponentDefinition
extends  ComponentDefinition

@export var item_definition: ItemDefinition

func get_component() -> WieldComponent:
	return WieldComponent.new(self)
