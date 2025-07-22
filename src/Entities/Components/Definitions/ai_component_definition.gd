class_name AIComponentDefinition
extends ComponentDefinition

func get_component() -> AIComponent:
	return AIComponent.new(self)
