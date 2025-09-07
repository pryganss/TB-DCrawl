class_name FighterComponent
extends Component

const TYPE = cpnt.FIGHTER

var level: int

var status: Array[Status] = []

signal turn_ended
signal turn_started

signal damage_started

signal died()
signal damage_ended()
signal damaged

var MAX_HP: int:
	set(value):
		MAX_HP = max(value, 1)

var hp: int:
	set(value):
		hp = min(value, MAX_HP)
		if hp <= 0 && not dying:
			dying = true
			die()
		damaged.emit()

var BASE_ARMOR: int:
	set(value):
		BASE_ARMOR = max(value, 0)

var armor: int:
	set(value):
		armor = max(value, 0)

var dying = false

var stance: Stance

func _init(component_definition: FighterComponentDefinition):
	MAX_HP = component_definition.max_hp
	hp = MAX_HP
	level = component_definition.level
	BASE_ARMOR = component_definition.armor
	armor = BASE_ARMOR

	ready.connect(func():
		if component_definition.starting_status:
			for st in component_definition.starting_status:
				stat.STATUS[st.status].call(entity, st.duration))

func damage(value: int, color: Color, ignore_armor: = false):
	damage_started.emit({"amount": value, "entity": entity}, "damage_started")
	var damage_taken := value
	if not ignore_armor:
		damage_taken = ceili(value / (1.0 + (armor / 10.0)))
	hp -= damage_taken
	entity.flash(color)
	damage_ended.emit({"amount": damage_taken, "entity": entity}, "damage_ended")
	armor = BASE_ARMOR

func refresh_status():
	for st in status:
		st.reconnect()

func die():
	status = []

	var wield_component: WieldComponent = entity.components.get(cpnt.WIELD) as WieldComponent

	if wield_component:
		wield_component.drop_item()

	if entity.blocker && entity != Map.player:
		Map.astar.set_point_solid(entity.grid_position, false)

	died.emit({"entity": entity}, "died")
