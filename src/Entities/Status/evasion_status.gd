class_name EvasionStatus
extends OnHitStatus

func apply(_args, _signal_name = "unnamed_signal"):
	if randf() < 0.7:
		var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
		fighter_component.damage_taken = 0
		entity.flash(Color.BLUE)
