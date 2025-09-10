class_name FuryStatus
extends OnAttackHitStatus

func apply(_args, _signal_name = "unnamed_signal"):
	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent

	melee_component.damage_dealt += ceili(float(melee_component.damage_dealt) * (
		float(fighter_component.MAX_HP - fighter_component.hp) / (3.0 + float(fighter_component.level * 2))))
