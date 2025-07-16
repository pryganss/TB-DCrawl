class_name ActionWithDirection
extends Action

var offset: Vector2i

func _init(acting_entity: Entity, dx: int, dy: int):
	super._init(acting_entity)
	offset = Vector2i(dx, dy)
