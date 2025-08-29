extends Control

func _on_start_button_pressed() -> void:
	Map.new_level()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
