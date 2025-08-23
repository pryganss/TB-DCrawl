class_name AIComponent
extends Component

const TYPE = cpnt.AI

func get_action() -> Action:
	assert(entity.components.get(cpnt.FIGHTER))

	var step = _get_step_to_location(Map.player.grid_position)

	if Map.get_entities_at_tile(step).has(Map.player) and entity.components.get(cpnt.MELEE):
		return MeleeAction.new(entity,
			step.x - entity.grid_position.x,
			step.y - entity.grid_position.y)

	elif entity.components.get(cpnt.MOVEMENT) and not Map.get_entities_at_tile(step):
		return MoveAction.new(entity,
			step.x - entity.grid_position.x,
			step.y - entity.grid_position.y)

	else: return WaitAction.new(entity)


func _get_step_to_location(target: Vector2i) -> Vector2i:
	var step = Map.astar.get_id_path(entity.grid_position, target, true)[1]

	return step
