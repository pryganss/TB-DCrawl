class_name MovementComponent
extends InitiativeComponent

const TYPE = cpnt.MOVEMENT

func move(target_position: Vector2i):
	var blockers = Map.get_entities_at_tile(target_position)
	var door_component: DoorComponent

	if blockers.size() == 1:
		door_component = blockers[0].components.get(cpnt.DOOR)

	if Map.get_tile(target_position).get_custom_data("WALKABLE"):
		if blockers.any(func(e: Entity): return e.blocker):
			return 0
		if entity.blocker && entity != Map.player:
			Map.astar.set_point_solid(entity.grid_position, false)
			Map.astar.set_point_solid(target_position)
		entity.grid_position = target_position
	elif door_component:
		door_component.open_door()
	else: return 0

	return delay
