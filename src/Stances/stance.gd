class_name Stance
extends RefCounted

var status: Array[Status] = []
var entity: Entity

func _init(stance_definition: StanceDefinition, stanced_entity: Entity):
	entity = stanced_entity

	if stance_definition.status:
		for st in stance_definition.status:
			status.append(stat.STATUS[st.status].call(entity, st.duration))

func change_stance(stance_definition: StanceDefinition):
	for st in status:
		st.clear_status()

	entity.components.get(cpnt.FIGHTER).stance = Stance.new(stance_definition, entity)
