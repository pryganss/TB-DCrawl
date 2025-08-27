class_name AttackScalingStatus
extends OnAttackStartStatus

var _cooldown_timer = 1000
var _current_scaling = 0:
	set(value):
		_current_scaling = max(0, min(value, max_scaling))

var max_scaling = 10

func apply(_args: Array):
	if not Map.new_game_tick.is_connected(_decrement_cooldown):
		Map.new_game_tick.connect(_decrement_cooldown)
	entity.components.get(cpnt.MELEE).mod += _current_scaling
	_current_scaling += 1
	_cooldown_timer = 1000

func _decrement_cooldown():
	_cooldown_timer -= 1
	if _cooldown_timer <= 0:
		_current_scaling -= 1
		_cooldown_timer = 200
