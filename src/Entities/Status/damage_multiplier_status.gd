class_name DamageMultiplierStatus
extends OnAttackStartStatus

func apply(_args = {}, _signal_name = "unnamed_signal"):
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	melee_component.mod += floori(
		float(Attack.damage(melee_component.BASE_DAMAGE, melee_component.BASE_MOD))
		* (float(melee_component.BASE_DELAY) / 150.0))
