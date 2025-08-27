class_name StanceButton
extends Button

var offered_stance: StanceDefinition

func change_offered_stance(stance_definition: StanceDefinition):
	offered_stance = stance_definition

	%Title.text = offered_stance.name
	%Description.text = offered_stance.description

func _on_pressed() -> void:
	var fighter_component = Map.player.components.get(cpnt.FIGHTER) as FighterComponent
	if fighter_component.stance:
		fighter_component.stance.change_stance(offered_stance)
	else:
		fighter_component.stance = Stance.new(offered_stance, Map.player)
