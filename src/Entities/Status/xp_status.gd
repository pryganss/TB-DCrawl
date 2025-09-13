class_name XPStatus
extends OnKillStatus

signal xp_updated()

var xp_to_next_level: int = 60:
	set(value):
		while value < 0:
			level_up()
			value += fighter_component.level * 80
		xp_to_next_level = value
		xp_updated.emit()

var fighter_component: FighterComponent

func on_kill(args: Dictionary, _signal_name = "unnamed_signal"):
	assert(entity == Map.player, "Tried to give XP to non player entity")

	if not fighter_component:
		fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent

	var killed_entity = args["entity"] as Entity

	var enemy_fighter_component = killed_entity.components.get(cpnt.FIGHTER) as FighterComponent
	xp_to_next_level -= max(enemy_fighter_component.level * 10, 5)

func level_up():
	fighter_component.level += 1
	fighter_component.MAX_HP += fighter_component.level * 5
	fighter_component.hp += fighter_component.level * 5
	fighter_component.BASE_ARMOR += fighter_component.level * 2
	fighter_component.armor += fighter_component.level * 2
