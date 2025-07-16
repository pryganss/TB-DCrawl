class_name InitiativeComponent
extends Component

var BASE_DELAY: int:
	set(value):
		BASE_DELAY = max(value, 1)

var delay: int:
	set(value):
		delay = max(value, 1)

func _init(component_definition: InitiativeComponentDefinition):
	BASE_DELAY = component_definition.delay
	delay = BASE_DELAY
