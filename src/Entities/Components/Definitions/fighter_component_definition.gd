class_name FighterComponentDefinition
extends ComponentDefinition

@export var max_hp: int

func get_component() -> FighterComponent:
	return FighterComponent.new(self)
