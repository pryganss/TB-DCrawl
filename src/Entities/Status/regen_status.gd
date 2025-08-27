class_name RegenStatus
extends Status

var counter: int = 50

func _init(affected_entity, start_duration):
	super._init(affected_entity, start_duration)

func _get_triggers():
	return [Map.new_game_tick]

func apply(_args = []):
	if counter >= 50:
		var fighter_component: FighterComponent = entity.components.get(cpnt.FIGHTER) as FighterComponent
		fighter_component.hp += 1
		counter -= 50

	counter += 1
