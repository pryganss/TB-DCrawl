class_name OnKillStatus
extends Status

func _get_triggers():
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	return [melee_component.attack_started, melee_component.attack_ended]

func apply(args: Dictionary = {}, signal_name = "unnamed_signal"):
	var fighter_component = args["target"] as FighterComponent
	if signal_name == "attack_started":
		fighter_component.died.connect(on_kill)
	else:
		fighter_component.died.disconnect(on_kill)

func on_kill(_args: Dictionary, _signal_name = "unnamed_signal"):
	assert(false, "Tried to apply unapplyable status")
