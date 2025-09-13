class_name DamageMultiplierStatus
extends OnAttackHitStatus

func apply(_args = {}, _signal_name = "unnamed_signal"):
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	melee_component.damage_dealt = melee_component.damage_dealt * (1 + (melee_component.delay / 180))
