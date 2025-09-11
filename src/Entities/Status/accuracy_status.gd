class_name AccuracyStatus
extends OnAttackStartStatus

func apply(_args, _signal_name = "unnamed_signal"):
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	if not melee_component.rolled_hit:
		melee_component.rolled_hit = (randf() < 0.5)
		entity.flash(Color.BLUE)
	else:
		var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
		await melee_component.attack_hit
		melee_component.damage_dealt += ceili(float(melee_component.damage_dealt) * (float(fighter_component.level) / (2.0 + float(fighter_component.level))))
