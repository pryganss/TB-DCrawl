extends CanvasLayer

var fighter_component: FighterComponent
var wield_component: WieldComponent

func update_health():
	if not fighter_component:
		fighter_component = Map.player.components.get(cpnt.FIGHTER) as FighterComponent

	%HealthBar.value = float(fighter_component.hp) / float(fighter_component.MAX_HP) * 100.0

func update_item(_args = {}, _signal_name = ""):
	if not wield_component:
		wield_component = Map.player.components.get(cpnt.WIELD) as WieldComponent

	var item = wield_component.item

	if item:
		%Item.texture = item.texture
	else:
		%Item.texture = null
