class_name MovementComponent
extends InitiativeComponent

func _init(component_definition: MovementComponentDefinition):
	super._init(component_definition)
	name = "MovementComponent"

func move(target_position: Vector2i):
	if Map.get_tile(target_position).get_custom_data("WALKABLE"):
		var blocker = Map.get_entity_at_tile(target_position)
		if blocker:
			if blocker.blocker:
				return 0
		entity.grid_position = target_position
	else: return 0

	return delay
