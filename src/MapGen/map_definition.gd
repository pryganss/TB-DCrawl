class_name MapDefinition
extends Resource

@export var room_types: Array[RoomDefinition]
@export var exit_room: RoomDefinition = preload("res://Assets/MapGen/Rooms/exit_room.tres")
@export var number_of_rooms: int = 5
