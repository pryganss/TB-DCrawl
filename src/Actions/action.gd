class_name Action
extends RefCounted

var next_turn: int = 0
var entity: Entity

func _init(acting_entity: Entity):
	self.entity = acting_entity

func perform() -> int:
	assert(false, "Tried to perform unperformable action")
	return next_turn
