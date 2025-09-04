extends Panel

var current_stance: StanceDefinition

func update_stance(stance_definition: StanceDefinition):
	current_stance = stance_definition
	$"Stance Icon".texture = current_stance.icon

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltip = preload("res://src/UI/tooltip.tscn").instantiate()

	if current_stance:
		tooltip.change_text(current_stance.name, current_stance.description)

	return tooltip
