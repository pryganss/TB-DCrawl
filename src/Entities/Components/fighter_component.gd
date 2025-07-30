class_name FighterComponent
extends Component

const TYPE = cpnt.FIGHTER

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

func die():
	died.emit(entity)
