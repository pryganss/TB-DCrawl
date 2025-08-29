class_name EventHandler
extends Node

var disabled = false

func get_action() -> Action:
	if disabled: return null

	var action: Action = null

	if Input.is_action_just_pressed("move_up"):
		action = BumpAction.new(Map.player, 0, -1)
	elif Input.is_action_just_pressed("move_down"):
		action = BumpAction.new(Map.player, 0, 1)
	elif Input.is_action_just_pressed("move_left"):
		action = BumpAction.new(Map.player, -1, 0)
	elif Input.is_action_just_pressed("move_right"):
		action = BumpAction.new(Map.player, 1, 0)

	elif Input.is_action_just_pressed("drop"):
		action = DropAction.new(Map.player)
	elif Input.is_action_just_pressed("grab"):
		action = GrabAction.new(Map.player)

	elif Input.is_action_just_pressed("wait"):
		action = WaitAction.new()

	return action
