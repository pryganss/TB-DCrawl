class_name MeleeComponentDefinition
extends InitiativeComponentDefinition

@export var damage: Array[String] = ["1d2"]
@export var mod: int = 0
@export var status: Array[Dictionary] = [{ "status": "", "duration": -1 }]

func get_component():
	return MeleeComponent.new(self)
