class_name StanceDefinition
extends Resource

@export var status: Array[StatusDefinition]

@export_category("UI")
@export var name: String = "unnamed_stance"
@export var icon: Texture = preload("res://Assets/Icons/divided-spiral.svg")
@export_multiline var description: String = "No Description"
