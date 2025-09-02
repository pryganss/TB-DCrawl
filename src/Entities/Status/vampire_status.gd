class_name VampireStatus
extends OnAttackEndStatus

func apply(args = {}, _signal_name = "unnamed_signal"):
	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	var damage_dealt = args["damage"] as int

	fighter_component.hp += ceili(float(damage_dealt) * (float(fighter_component.level) / 5.0))
