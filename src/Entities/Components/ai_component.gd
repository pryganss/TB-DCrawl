class_name AIComponent
extends Component

const TYPE = cpnt.AI

func get_action() -> Action:
	assert(entity.components.get(cpnt.FIGHTER), "Entity without FighterComponent requested action from AIComponent")

	var step = _get_step_to_location(Map.player.grid_position)

	if Map.get_entities_at_tile(step).has(Map.player) and entity.components.get(cpnt.MELEE):
		return MeleeAction.new(entity,
			step.x - entity.grid_position.x,
			step.y - entity.grid_position.y)

	elif entity.components.get(cpnt.MOVEMENT) and not Map.get_entities_at_tile(step).any(func(e): return e.blocker):
		return MoveAction.new(entity,
			step.x - entity.grid_position.x,
			step.y - entity.grid_position.y)

	else: return WaitAction.new()


func _get_step_to_location(target: Vector2i) -> Vector2i:
	var steps = Map.astar.get_id_path(entity.grid_position, target, true)

	if steps.size() > 1:
		return steps[1]
	return steps[0]
