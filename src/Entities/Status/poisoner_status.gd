class_name PoisonerStatus
extends OnAttackHitStatus

func apply(args, _signal_name = "unnamed_signal"):
	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	if randf() < (float(fighter_component.level) / float(2 + fighter_component.level)):
		print("poison")
		DamageOverTimeStatus.new(args["target"].entity, 500)
