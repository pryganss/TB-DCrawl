class_name Action
extends RefCounted

var next_turn: int = 1

func perform(_entity: Entity) -> int:
	return next_turn
