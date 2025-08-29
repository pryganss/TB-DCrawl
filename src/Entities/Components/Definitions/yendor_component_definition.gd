class_name YendorComponentDefinition
extends ComponentDefinition

func get_component() -> YendorComponent:
	return YendorComponent.new(self)
