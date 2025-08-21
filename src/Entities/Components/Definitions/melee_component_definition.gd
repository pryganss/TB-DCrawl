class_name MeleeComponentDefinition
extends InitiativeComponentDefinition

@export var damage: Array[String] = ["1d2"]
@export var mod: int = 0

func get_component():
	return MeleeComponent.new(self)
