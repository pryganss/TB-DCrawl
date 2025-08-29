class_name YendorComponent
extends Component

const TYPE = cpnt.STAIR

func _init(_component_definition: ComponentDefinition):
	var fighter_component = Map.player.components.get(cpnt.FIGHTER) as FighterComponent
	fighter_component.turn_ended.connect(win)

func win(args: Dictionary, _signal_name):
	if args["entity"].grid_position == entity.grid_position:
		Map.win()
