class_name GameManager
extends Node2D

@onready var entities: Node = $Entities
@onready var game_map: TileMapLayer = $Map
@onready var event_handler: EventHandler = $EventHandler
@onready var stance_files: PackedStringArray = ResourceLoader.list_directory("res://Assets/Stances/")
@export var stances: Array[StanceDefinition] = []

var stance_timer: = 0

func _ready():
	Map.game_map = game_map
	Map.entities = entities

	for file in stance_files:
		stances.append(load("res://Assets/Stances/" + file))

	Map.map_ready.emit()


func connect_player():
	var plr_fighter_component: FighterComponent = Map.player.components.get(cpnt.FIGHTER) as FighterComponent

	plr_fighter_component.died.connect(reset)
	plr_fighter_component.damaged.connect($UI.update_health)

	Map.player.components.get(cpnt.WIELD).item_changed.connect($UI.update_item)

	$UI.connect_player()
	$UI.update_health()
	$UI.update_item()

	$"UI/New Stance UI".event_handler = event_handler

	Map.new_room.connect(_decrement_stance)
	_new_stance()

func reset(_args: Dictionary, _signal_name = "unnamed_signal"):
	Map.current_floor = 0
	get_tree().change_scene_to_file("res://src/UI/main_menu.tscn")

func _physics_process(_delta):
	var entity = Initiative.get_current_turn()
	if entity == Map.player:
		var action: Action
		action = event_handler.get_action()
		if action:
			Initiative.take_turn(action, entity)
	elif entity:
		var action: Action = entity.components.get(cpnt.AI).get_action()
		Initiative.take_turn(action, entity)

func _new_stance():
	var stance_1: StanceDefinition
	var stance_2: StanceDefinition

	var available_stances: Array[StanceDefinition] = stances.duplicate()

	stance_1 = (func():
		var chosen_stance = available_stances.pick_random()
		available_stances.erase(chosen_stance)
		return chosen_stance).call()
	stance_2 = available_stances.pick_random()

	$"UI/New Stance UI".new_stance(stance_1, stance_2)

	stance_timer = randi_range(4, 8)

func _decrement_stance(_args, _signal_name):
	stance_timer -= 1
	if stance_timer <= 0:
		await Map.player.components.get(cpnt.FIGHTER).turn_started
		_new_stance()
