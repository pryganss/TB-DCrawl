class_name FighterComponent
extends Component

var MAX_HP: int:
	set(value):
		MAX_HP = max(value, 1)

var hp: int:
	set(value):
		hp = min(value, MAX_HP)

var BASE_ATTACK_DELAY: int:
	set(value):
		BASE_ATTACK_DELAY = max(value, 1)

var attack_delay: int:
	set(value):
		attack_delay = max(value, 1)

func _init(component_definition: FighterComponentDefinition):
	name = "FighterComponent"
	MAX_HP = component_definition.max_hp
	hp = MAX_HP
	BASE_ATTACK_DELAY = component_definition.attack_delay
	attack_delay = BASE_ATTACK_DELAY

