class_name GrabAction
extends Action

func perform() -> int:
	var drop: Item
	for tile_entity in Map.get_entities_at_tile(entity.grid_position):
		var item_component: ItemComponent = tile_entity.components.get(cpnt.ITEM)
		if item_component:
			drop = item_component.item
			tile_entity.queue_free()
			break
	if not drop: return next_turn

	var wield_component: WieldComponent = entity.components.get(cpnt.WIELD)
	if not wield_component: return next_turn

	if wield_component.item:
		next_turn += DropAction.new(entity).perform()

	next_turn += wield_component.equip_item(drop)

	return next_turn
