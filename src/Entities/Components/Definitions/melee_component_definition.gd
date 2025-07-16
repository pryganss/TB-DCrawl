class_name MeleeComponentDefinition
extends InitiativeComponentDefinition

@export var damage: int = 1

func get_component():
	return MeleeComponent.new(self)
