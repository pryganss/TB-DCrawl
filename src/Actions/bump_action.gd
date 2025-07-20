class_name BumpAction
extends ActionWithDirection

func perform() -> int:
	var blocker = Map.get_entity_at_tile(entity.grid_position + offset)
	if blocker:
		if blocker.components.get("FighterComponent"):
			next_turn += MeleeAction.new(entity, offset.x, offset.y).perform()
		else:
			next_turn += MoveAction.new(entity, offset.x, offset.y).perform()
		return next_turn
	else:
		next_turn += MoveAction.new(entity, offset.x, offset.y).perform()
	return next_turn
