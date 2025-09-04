class_name MeleeComponent
extends InitiativeComponent

const TYPE = cpnt.MELEE

var BASE_DAMAGE: Array[String]
var BASE_MOD: int
var damage: Array[String]
var mod: int

var status: Array[StatusDefinition]

signal attack_started(_args: Array)
signal attack_ended(_args: Array)

func _init(component_definition: MeleeComponentDefinition):
	super._init(component_definition)
	BASE_DAMAGE = component_definition.damage
	BASE_MOD = component_definition.mod
	damage = BASE_DAMAGE
	mod = BASE_MOD
	status = component_definition.status

func hit(target: FighterComponent) -> int:
	var fighter_component: FighterComponent = entity.components.get(cpnt.FIGHTER)
	if not fighter_component: return 0

	var damage_dealt = 0

	attack_started.emit({"target": target}, "attack_started")

	if Attack.to_hit(fighter_component.level - target.level):
		damage_dealt = Attack.damage(damage, mod)
		target.damage(damage_dealt, Color.RED)
		if status:
			for st in status:
				stat.STATUS[st.status].call(target.entity, st.duration)

	attack_ended.emit({"target": target, "damage": damage_dealt}, "attack_ended")

	damage = BASE_DAMAGE
	mod = BASE_MOD
	return delay
