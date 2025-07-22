class_name WaitAction
extends Action

func perform() -> int:
	next_turn += 100
	return next_turn
