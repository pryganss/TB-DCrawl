class_name MovementComponentDefinition
extends InitiativeComponentDefinition

func get_component() -> MovementComponent:
	return MovementComponent.new(self)
