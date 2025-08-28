class_name FighterComponent
extends Component

const TYPE = cpnt.FIGHTER

var level: int

var status: Array[Status] = []

signal turn_ended
signal turn_started

signal damage_started

signal died(entity: Entity)
signal damage_ended()
signal damaged

var MAX_HP: int:
	set(value):
		MAX_HP = max(value, 1)

var hp: int:
	set(value):
		hp = min(value, MAX_HP)
		if hp <= 0: die()
		damaged.emit()

var BASE_ARMOR: int:
	set(value):
		armor = max(value, 0)

var armor: int:
	set(value):
		armor = max(value, 0)

var stance: Stance

func _init(component_definition: FighterComponentDefinition):
	MAX_HP = component_definition.max_hp
	hp = MAX_HP
	level = component_definition.level
	BASE_ARMOR = component_definition.armor
	armor = BASE_ARMOR

func damage(value):
	damage_started.emit({"amount": value, "entity": entity}, "damage_started")
	var reduced_damage = ceili(value / (1.0 + (armor / 10.0)))
	hp -= reduced_damage
	damage_ended.emit({"amount": reduced_damage, "entity": entity}, "damage_ended")
	armor = BASE_ARMOR

func refresh_status():
	for st in status:
		st.reconnect()

func die():
	status = []

	var wield_component: WieldComponent = entity.components.get(cpnt.WIELD) as WieldComponent

	if wield_component:
		wield_component.drop_item()

	died.emit(entity)
