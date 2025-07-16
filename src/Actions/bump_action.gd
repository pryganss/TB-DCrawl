class_name BumpAction
extends ActionWithDirection

func perform() -> int:
	if Map.get_entity_at_tile(entity.grid_position + offset):
		next_turn += MeleeAction.new(entity, offset.x, offset.y).perform()
	else:
		next_turn += MoveAction.new(entity, offset.x, offset.y).perform()
	return next_turn
