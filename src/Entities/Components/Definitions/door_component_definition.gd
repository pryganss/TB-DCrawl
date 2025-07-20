class_name DoorComponentDefinition
extends ComponentDefinition

func get_component() -> DoorComponent:
	return DoorComponent.new(self)
