class_name DoorComponent
extends Component

const TYPE = cpnt.DOOR

var room

func _ready():
	room = Map.wall_tiles[entity.grid_position].filter(func(r):
		return not r.placed)[0]
	pass

func open_door():
	if not room.placed:
		for door in room.draw_room(Map.game_map):
			Initiative.add_entity(door)

	Map.erase_auto_tile(entity.grid_position)
	Map.game_map.set_cell(entity.grid_position, 0, Map.TILES["FLOOR"])
	Map.astar.set_point_solid(entity.grid_position, false)

	# Heal Player
	if Map.player.components.get(cpnt.FIGHTER).status.any(func(s): return s is BuffDoorHealingStatus):
		Map.player.components.get(cpnt.FIGHTER).hp += 10
	else:
		Map.player.components.get(cpnt.FIGHTER).hp += 7

	entity.queue_free()
	pass
