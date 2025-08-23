class_name FighterComponent
extends Component

const TYPE = cpnt.FIGHTER

var level: int

## Status Trigers
# END = on affected entities turn end
var status: Dictionary[String, Array]

signal turn_ended

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


func _init(component_definition: FighterComponentDefinition):
	MAX_HP = component_definition.max_hp
	hp = MAX_HP
	level = component_definition.level

	turn_ended.connect(turn_end)

func die():
	status = {}

	var wield_component: WieldComponent = entity.components.get(cpnt.WIELD) as WieldComponent

	if wield_component:
		wield_component.drop_item()

	died.emit(entity)

func turn_end():
	if status.get("END"):
		for st in status.get("END") as Array[Status]:
			st.apply([])
