class_name MovementComponentDefinition
extends ComponentDefinition

@export var move_delay: int

func get_component() -> Component:
	return MovementComponent.new(self)
