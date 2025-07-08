class_name MoveAction
extends Action

var offset: Vector2i

func _init(dx, dy) -> void:
	offset = Vector2i(dx, dy)

func perform(_game_manager: GameManager, entity: Entity) -> void:
	entity.move(offset)
