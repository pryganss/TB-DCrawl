class_name RegenStatus
extends Status

var counter: int = 50

func _get_triggers():
	return [Map.new_game_tick]

func apply(_args = {}, _signal_name = "unnamed_signal"):
	if counter >= 50:
		var fighter_component: FighterComponent = entity.components.get(cpnt.FIGHTER) as FighterComponent
		fighter_component.hp += 1
		counter -= 50

	counter += 1
