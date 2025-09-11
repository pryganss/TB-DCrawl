class_name MeleeComponent
extends InitiativeComponent

const TYPE = cpnt.MELEE

var BASE_DAMAGE: Array[String]
var BASE_MOD: int
var damage: Array[String]
var mod: int

var damage_dealt = 0

var status: Array[StatusDefinition]

var rolled_hit: bool = false

signal attack_started(_args: Array)
signal attack_ended(_args: Array)
signal attack_hit(_args: Array, signal_name: String)

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

	rolled_hit = Attack.to_hit(fighter_component.level - target.level)

	attack_started.emit({"target": target}, "attack_started")

	if rolled_hit:
		damage_dealt = Attack.damage(damage, mod)
		attack_hit.emit({"target": target, "damage": damage_dealt}, "attack_hit")
		target.damage(damage_dealt, Color.RED)
		if status:
			for st in status:
				stat.STATUS[st.status].call(target.entity, st.duration)
	else:
		target.entity.flash(Color.LIGHT_GRAY)

	attack_ended.emit({"target": target, "damage": damage_dealt}, "attack_ended")

	damage = BASE_DAMAGE
	mod = BASE_MOD
	damage_dealt = 0
	return delay
