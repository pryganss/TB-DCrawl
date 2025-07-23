class_name MeleeAction
extends ActionWithDirection

func perform() -> int:
	var melee_component: MeleeComponent = entity.components.get("MeleeComponent") as MeleeComponent
	assert(melee_component)

	var target_entity: Entity
	for e in Map.get_entities_at_tile(entity.grid_position + offset):
		if e.components.get("FighterComponent"):
			target_entity = e

	if target_entity:
		var target_fighter_component: FighterComponent = target_entity.components.get("FighterComponent")
		next_turn += melee_component.hit(target_fighter_component)
	return next_turn
