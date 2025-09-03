class_name ArmorFromDamageStatus
extends OnHitStatus

var last_attack_damage = 0.0

func apply(args: Dictionary, signal_name: String = "unnamed_signal"):
	if signal_name == "attack_ended":
		if not args["damage"] == 0:
			last_attack_damage = float(args["damage"])
	else:
		var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
		var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
		fighter_component.armor += ceili(last_attack_damage * (0.25 + (float(melee_component.BASE_DELAY) / 100.0)))

func _get_triggers():
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	return super._get_triggers() + [melee_component.attack_ended]
