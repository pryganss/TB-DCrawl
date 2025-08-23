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

var entity: Entity

func _init(affected_entity: Entity):
	entity = affected_entity

func apply(_args: Array):
	assert(false)

func _decrement():
	duration -= 1

func clear_status():
	assert(false)
