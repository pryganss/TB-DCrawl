class_name FighterComponent
extends Component

var MAX_HP: int:
	set(value):
		MAX_HP = max(value, 1)

var hp: int:
	set(value):
		hp = min(value, MAX_HP)

func _init(component_definition: FighterComponentDefinition):
	name = "FighterComponent"
	MAX_HP = component_definition.max_hp
	hp = MAX_HP
