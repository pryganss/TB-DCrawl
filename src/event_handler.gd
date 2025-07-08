class_name EventHandler
extends Node

static func get_action() -> Action:
	var action: Action = null

	if Input.is_action_just_pressed("ui_up"):
		action = MoveAction.new(0, -1)
	elif Input.is_action_just_pressed("ui_down"):
		action = MoveAction.new(0, 1)
	elif Input.is_action_just_pressed("ui_left"):
		action = MoveAction.new(-1, 0)
	elif Input.is_action_just_pressed("ui_right"):
		action = MoveAction.new(1, 0)

	return action
