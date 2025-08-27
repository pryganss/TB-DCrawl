class_name OnAttackStartStatus
extends Status

func _init(affected_entity: Entity, start_duration):
	super._init(affected_entity, start_duration)

func _get_triggers():
	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	return [melee_component.attack_started]
