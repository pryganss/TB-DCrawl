extends CanvasLayer

var fighter_component: FighterComponent

func update_health():
	if not fighter_component:
		fighter_component = Map.player.components.get(cpnt.FIGHTER) as FighterComponent

	%HealthBar.value = float(fighter_component.hp) / float(fighter_component.MAX_HP) * 100.0
