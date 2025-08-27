class_name FighterComponentDefinition
extends ComponentDefinition

@export var max_hp: int = 5
@export var level: int = 1
@export var armor: int = 0

func get_component() -> FighterComponent:
	return FighterComponent.new(self)
