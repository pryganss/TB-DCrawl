class_name MeleeAction
extends ActionWithDirection

func perform() -> int:
	var fighter_component: FighterComponent = entity.components.get("FighterComponent") as FighterComponent
	assert(fighter_component)

	var target_entity: Entity = Map.get_entity_at_tile(entity.grid_position + offset)
	if target_entity:
		var target_fighter_component: FighterComponent = target_entity.components.get("FighterComponent")
		if target_fighter_component:
			target_fighter_component.hp -= 1
			next_turn += fighter_component.attack_delay
	return next_turn
