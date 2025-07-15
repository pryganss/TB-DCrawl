class_name MoveAction
extends Action

var offset: Vector2i

func _init(acting_entity: Entity, dx: int, dy: int) -> void:
	super._init(acting_entity)
	offset = Vector2i(dx, dy)

func perform() -> int:
	var movement_component: MovementComponent = entity.components["MovementComponent"]

	next_turn += movement_component.move(entity.grid_position + offset)
	return next_turn
