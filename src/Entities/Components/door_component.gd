class_name DoorComponent
extends Component

var room: MapLeaf

func _init(_component_definition: DoorComponentDefinition):
	name = "DoorComponent"

func _ready():
	room = Map.wall_tiles[entity.grid_position].filter(func(r):
		return not r.placed)[0]

func open_door():
	if not room.placed:
		for door in room.draw_room(Map.game_map):
			Map.entities.add_child(door)

	Map.erase_auto_tile(entity.grid_position)
	Map.game_map.set_cell(entity.grid_position, 0, Map.TILES["FLOOR"])

	entity.queue_free()
