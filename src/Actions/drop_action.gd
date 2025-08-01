class_name DropAction
extends Action

func perform() -> int:
	var wield_component: WieldComponent = entity.components.get(cpnt.WIELD) as WieldComponent
	if wield_component: wield_component.drop_item()

	return next_turn
