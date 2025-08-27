extends Panel

@onready var button_1: StanceButton = $"Stance Buttons/1"
@onready var button_2: StanceButton = $"Stance Buttons/2"

var event_handler: EventHandler

func _ready():
	var hide_button = func():
		visible = false
		event_handler.disabled = false
	button_1.pressed.connect(hide_button)
	button_2.pressed.connect(hide_button)

func new_stance(stance_1: StanceDefinition, stance_2: StanceDefinition):
	button_1.change_offered_stance(stance_1)
	button_2.change_offered_stance(stance_2)
	event_handler.disabled = true
	visible = true
