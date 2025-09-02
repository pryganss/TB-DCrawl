class_name AttackScalingStatus
extends OnAttackStartStatus

var _cooldown_timer = 600
var _current_scaling = 0.0:
	set(value):
		_current_scaling = max(0.0, min(value, max_scaling))

var max_scaling = 10.0

func apply(_args = {}, _signal_name = "unnamed_signal"):
	if not Map.new_game_tick.is_connected(_decrement_cooldown):
		Map.new_game_tick.connect(_decrement_cooldown)

	var melee_component = entity.components.get(cpnt.MELEE) as MeleeComponent
	melee_component.mod += ceili(_current_scaling)
	_current_scaling += 1.0 / (melee_component.delay / 80.0)
	_cooldown_timer = 600

func _decrement_cooldown(_args, _signal_name):
	_cooldown_timer -= 1
	if _cooldown_timer <= 0:
		_current_scaling -= 1
		_cooldown_timer = 100
