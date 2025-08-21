class_name MeleeComponent
extends InitiativeComponent

const TYPE = cpnt.MELEE

var BASE_DAMAGE: Array[String]
var BASE_MOD: int
var damage: Array[String]
var mod: int

func _init(component_definition: MeleeComponentDefinition):
	super._init(component_definition)
	BASE_DAMAGE = component_definition.damage
	BASE_MOD = component_definition.mod
	damage = BASE_DAMAGE
	mod = BASE_MOD

func hit(target: FighterComponent) -> int:
	var fighter_component: FighterComponent = entity.components.get(cpnt.FIGHTER)
	if not fighter_component: return 0

	if Attack.to_hit(fighter_component.level - target.level): target.hp -= Attack.damage(damage, mod)

	return delay
