class_name FighterComponentDefinition
extends ComponentDefinition

@export var max_hp: int = 5
@export var level: int = 1
@export var armor: int = 0

@export var starting_status: Array[StatusDefinition]

func get_component() -> FighterComponent:
	return FighterComponent.new(self)
