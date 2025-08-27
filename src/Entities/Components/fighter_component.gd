class_name FighterComponent
extends Component

const TYPE = cpnt.FIGHTER

var level: int

var status: Array[Status] = []

signal turn_ended
signal turn_started

signal died(entity: Entity)
signal damaged()

var MAX_HP: int:
	set(value):
		MAX_HP = max(value, 1)

var hp: int:
	set(value):
		hp = min(value, MAX_HP)
		if hp <= 0: die()
		damaged.emit()

var stance: Stance

func _init(component_definition: FighterComponentDefinition):
	MAX_HP = component_definition.max_hp
	hp = MAX_HP
	level = component_definition.level

func die():
	status = []

	var wield_component: WieldComponent = entity.components.get(cpnt.WIELD) as WieldComponent

	if wield_component:
		wield_component.drop_item()

	died.emit(entity)
