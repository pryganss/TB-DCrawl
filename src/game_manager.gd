class_name GameManager
extends Node2D

@onready var player: Entity

@onready var entities: Node = $Entities
@onready var game_map: TileMapLayer = $Map
@onready var event_handler: EventHandler = $EventHandler

func _ready():
	Map.game_map = game_map
	Map.entities = entities

	player = MapGen.generate_map()
	Initiative.initiative[100] = player
	event_handler.player = player
	Map.player = player
	entities.add_child(player)

	var plr_fighter_component: FighterComponent = player.components.get(cpnt.FIGHTER) as FighterComponent

	plr_fighter_component.died.connect(reset)
	plr_fighter_component.damaged.connect($UI.update_health)

	player.components.get(cpnt.WIELD).item_changed.connect($UI.update_item)

	$UI.update_health()
	$UI.update_item()

	$Camera2D.player = player


func reset(_entity: Entity):
	get_tree().change_scene_to_file("res://game.tscn")

func _physics_process(_delta):
	var entity = Initiative.get_current_turn()
	if entity == player:
		var action: Action
		action = event_handler.get_action()
		if action:
			Initiative.take_turn(action, player)
	elif entity:
		var action: Action = entity.components.get(cpnt.AI).get_action()
		Initiative.take_turn(action, entity)
