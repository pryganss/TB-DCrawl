extends Node

var xp_status: XPStatus

@onready var xp_bar = $"XP Bar"

func _update_xp():
	if not xp_status.fighter_component: return
	$"Current Level".text = str(xp_status.fighter_component.level)
	if xp_status.fighter_component.level == 1:
		xp_bar.max_value = 60
	else:
		xp_bar.max_value = xp_status.fighter_component.level * 80

	xp_bar.value = xp_bar.max_value - xp_status.xp_to_next_level
