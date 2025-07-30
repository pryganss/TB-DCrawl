class_name BumpAction
extends ActionWithDirection

func perform() -> int:
	var blockers = Map.get_entities_at_tile(entity.grid_position + offset)
	if blockers.size():
		if blockers.any(func(e): return e.components.get(cpnt.FIGHTER)):
			next_turn += MeleeAction.new(entity, offset.x, offset.y).perform()
		else:
			next_turn += MoveAction.new(entity, offset.x, offset.y).perform()
		return next_turn
	else:
		next_turn += MoveAction.new(entity, offset.x, offset.y).perform()
	return next_turn
