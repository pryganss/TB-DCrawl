extends Camera2D

func _physics_process(_delta: float) -> void:
	if Map.player.is_inside_tree():
		position = Map.player.position
