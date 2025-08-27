class_name OnHitStatus
extends Status

func _init(affected_entity: Entity, start_duration: int):
	super._init(affected_entity, start_duration)

func _get_triggers():
	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	return [fighter_component.damage_started]
