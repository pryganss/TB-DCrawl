class_name MovementComponent
extends Component

var BASE_MOVE_DELAY: int:
	set(value):
		move_delay = max(value, 1)

var move_delay: int:
	set(value):
		move_delay = max(value, 1)

func _init(component_definition: MovementComponentDefinition):
	name = "MovementComponent"
	BASE_MOVE_DELAY = component_definition.move_delay
	move_delay = component_definition.move_delay

func move(target_position: Vector2i):
	if (Map.get_tile(target_position).get_custom_data("WALKABLE")
		and Map.get_entity_at_tile(target_position) is not Entity):

		entity.grid_position = target_position

	return move_delay
