class_name StairComponent
extends Component

const TYPE = cpnt.STAIR

func _init(_component_definition: ComponentDefinition):
	var fighter_component = Map.player.components.get(cpnt.FIGHTER) as FighterComponent
	fighter_component.turn_ended.connect(descend)

func descend(args: Dictionary, _signal_name):
	if args["entity"].grid_position == entity.grid_position:
		Map.current_floor += 1
		Map.new_level()
