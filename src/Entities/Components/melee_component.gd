class_name MeleeComponent
extends InitiativeComponent

var BASE_DAMAGE: int:
	set(value):
		BASE_DAMAGE = max(value, 0)

var damage: int:
	set(value):
		damage = max(value, 0)

func _init(component_definition: MeleeComponentDefinition):
	super._init(component_definition)
	name = "MeleeComponent"
	BASE_DAMAGE = component_definition.damage
	damage = BASE_DAMAGE

func hit(target: FighterComponent) -> int:
	target.hp -= damage
	return delay
