class_name Status
extends RefCounted

var duration: int = -1:
	set(value):
		assert(value >= -1)

		if value == 0:
			clear_status()

		if Map.new_game_tick.is_connected(_decrement):
			if value == -1:
				Map.new_game_tick.disconnect(_decrement)
		elif value > 0:
			Map.new_game_tick.connect(_decrement)

		duration = value

var _triggers: Array[String]

var entity: Entity

func _init(affected_entity: Entity, triggers: Array[String]):
	entity = affected_entity

	_triggers = triggers

	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent

	for trigger in triggers:
		if fighter_component.status.get(trigger):
			if not fighter_component.status.get(trigger).any(func(s): return typeof(s) ==  typeof(self)):
				fighter_component.status[trigger] += [self]
		else:
			fighter_component.status[trigger] = [self]

func apply(_args: Array):
	assert(false)

func _decrement():
	duration -= 1

func clear_status():
	for trigger in _triggers:
		entity.components.get(cpnt.FIGHTER).status[trigger].erase(self)

func extend_status(new_duration: int):
	var fighter_component = entity.components.get(cpnt.FIGHTER) as FighterComponent

	for trigger in _triggers:
		var status_index: int = fighter_component.status.get(trigger).find_custom(func(s): return typeof(s) ==  typeof(self))
		if fighter_component.status.get(trigger)[status_index]:
			if new_duration == -1:
				fighter_component.status.get(trigger)[status_index].duration = new_duration
			else: fighter_component.status.get(trigger)[status_index].duration = max(new_duration,
				fighter_component.status.get(trigger)[status_index].duration)
		else:
			if new_duration == -1:
				duration = new_duration
			else: duration = max(new_duration, duration)
