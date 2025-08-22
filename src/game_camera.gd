extends Camera2D

var player: Entity

func _physics_process(_delta: float) -> void:
	position = player.position
