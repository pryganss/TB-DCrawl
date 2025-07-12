class_name Actor
extends Entity

signal ended_turn

func move(target_position: Vector2i):
	if Map.get_tile(target_position).get_custom_data("WALKABLE"):
		grid_position = target_position
