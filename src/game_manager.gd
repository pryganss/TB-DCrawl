class_name GameManager
extends Node2D

const player_definition: EntityDefinition = preload("res://Assets/Entities/player_definition.tres")
@onready var player: Entity

func _ready():
	player = Entity.new(player_definition, Vector2i(5, 5))
	$Entities.add_child(player)

func _physics_process(_delta: float) -> void:
	var action: Action = EventHandler.get_action()
	if action:
		action.perform(self, player)
