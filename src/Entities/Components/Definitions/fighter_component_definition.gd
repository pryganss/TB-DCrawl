class_name FighterComponentDefinition
extends ComponentDefinition

@export var max_hp: int
@export var attack_delay: int = 100

func get_component() -> FighterComponent:
	return FighterComponent.new(self)
