class_name FighterComponentDefinition
extends ComponentDefinition

@export var max_hp: int = 5

func get_component() -> FighterComponent:
	return FighterComponent.new(self)
