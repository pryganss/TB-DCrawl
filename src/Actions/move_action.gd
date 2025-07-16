class_name MoveAction
extends ActionWithDirection

func perform() -> int:
	var movement_component: MovementComponent = entity.components["MovementComponent"]

	next_turn += movement_component.move(entity.grid_position + offset)
	return next_turn
