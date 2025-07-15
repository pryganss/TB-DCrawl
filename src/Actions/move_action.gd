class_name MoveAction
extends Action

var offset: Vector2i

func _init(dx, dy) -> void:
	offset = Vector2i(dx, dy)

func perform(entity: Entity) -> int:
	var movement_component: MovementComponent = entity.components["MovementComponent"]

	next_turn += movement_component.move(entity.grid_position + offset)
	return next_turn
