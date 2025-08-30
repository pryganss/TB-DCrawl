class_name DamageOverTimeStatus
extends GameTickStatus

var counter: int = 100

func apply(_args = {}, _signal_name = "unnamed_signal"):
	if counter >= 100:
		var fighter_component: FighterComponent = entity.components.get(cpnt.FIGHTER) as FighterComponent
		fighter_component.hp -= 1
		counter -= 100

	counter += 1
