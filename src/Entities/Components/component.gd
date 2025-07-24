class_name Component
extends Node

@onready var entity: Entity = get_parent() as Entity

func _init(_component_definition: ComponentDefinition):
	pass

func _ready():
	name = get_class()
