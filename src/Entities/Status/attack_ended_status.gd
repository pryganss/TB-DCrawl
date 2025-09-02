class_name OnAttackEndStatus
extends Status

func _get_triggers():
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	return [melee_component.attack_ended]
