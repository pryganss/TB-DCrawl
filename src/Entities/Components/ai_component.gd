class_name AIComponent
extends Component

func _init(_component_definition: AIComponentDefinition):
	name = "AIComponent"

func get_action() -> Action:
	var step = _get_step_to_location(Map.player.grid_position)

	if Map.get_entity_at_tile(step) == Map.player and entity.components.get("MeleeComponent"):
		return MeleeAction.new(entity,
			step.x - entity.grid_position.x,
			step.y - entity.grid_position.y)

	elif entity.components.get("MovementComponent") and not Map.get_entity_at_tile(step):
		return MoveAction.new(entity,
			step.x - entity.grid_position.x,
			step.y - entity.grid_position.y)

	else: return WaitAction.new(entity)


func _get_step_to_location(target: Vector2i) -> Vector2i:
	var step = Map.astar.get_id_path(entity.grid_position, target, true)[1]

	return step
