class_name Status
extends RefCounted

var duration: int = -1:
	set(value):
		assert(value >= -1, "Invalid duration set on Status object")

		if value == 0:
			clear_status()

		if Map.new_game_tick.is_connected(_decrement):
			if value == -1:
				Map.new_game_tick.disconnect(_decrement)
		elif value > 0:
			Map.new_game_tick.connect(_decrement)

		duration = value

var _triggers: Array

var entity: Entity

func _init(affected_entity: Entity, start_duration = -1):
	var fighter_component = affected_entity.components.get(cpnt.FIGHTER) as FighterComponent
	for status in fighter_component.status as Array[Status]:
		if status.get_script().get_global_name() == self.get_script().get_global_name():
			entity = affected_entity
			extend_status(start_duration)
			return

	entity = affected_entity

	fighter_component.status.append(self)

	duration = start_duration

	reconnect()

func _get_triggers() -> Array[Signal]:
	return _triggers

func reconnect():
	for trigger in _triggers:
		trigger.disconnect(apply)

	_triggers = _get_triggers()
	for trigger in _triggers:
		trigger.connect(apply)

func apply(_args: Dictionary, _signal_name: String = "unnamed_signal"):
	assert(false, "Tried to apply unapplyable status")

func _decrement(_args, _signal_name):
	duration -= 1

func clear_status():
	for trigger in _triggers:
		if trigger.is_connected(apply): trigger.disconnect(apply)

	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent
	fighter_component.status.erase(self)


func extend_status(new_duration: int):
	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent

	for trigger in _triggers:
		var status_index: int = fighter_component.status.find_custom(func(s): return typeof(s) ==  typeof(self))
		if fighter_component.status[status_index]:
			if new_duration == -1:
				fighter_component.status[status_index].duration = new_duration
			else: fighter_component.status[status_index].duration = max(new_duration,
				fighter_component.status[status_index].duration)
		else:
			if new_duration == -1:
				duration = new_duration
			else: duration = max(new_duration, duration)
