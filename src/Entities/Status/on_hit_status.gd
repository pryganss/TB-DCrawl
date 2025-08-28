class_name OnHitStatus
extends Status

func _get_triggers():
	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	return [fighter_component.damage_started]
