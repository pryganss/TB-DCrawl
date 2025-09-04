class_name DamageOverTimeStatus
extends GameTickStatus

var counter: int = 100

func apply(_args = {}, _signal_name = "unnamed_signal"):
	if counter >= 100:
		var fighter_component: FighterComponent = entity.components.get(cpnt.FIGHTER) as FighterComponent
		if fighter_component:
			fighter_component.damage(1, Color.GREEN, true)
		counter -= 100

	counter += 1
