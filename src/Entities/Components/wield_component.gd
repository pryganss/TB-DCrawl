class_name WieldComponent
extends InitiativeComponent

const TYPE = cpnt.WIELD

signal item_changed

var item: Item:
	set(value):
		item = value
		item_changed.emit()

var cached_components: Array[Component]
var starting_item: ItemDefinition

const drop_definition: EntityDefinition = preload("res://Assets/Entities/drop_definition.tres")

func _init(component_definition: WieldComponentDefinition):
	super._init(component_definition)
	starting_item = component_definition.item_definition

func _ready():
	entity.ready.connect(entity_ready)

func entity_ready():
	if starting_item: equip_item(starting_item)

func equip_item(item_definition: ItemDefinition):
	if item:
		return 0

	item = item_definition.get_item()
	for component in item.components:
		var base_component: Component = entity.components.get(component.TYPE)
		if base_component:
			cached_components += [base_component]
			base_component.queue_free()

		entity.add_child(component)
		entity.components[component.TYPE] = component

	return delay

func _unequip_item():
	for component in item.components:
		entity.components.erase(component.TYPE)
		component.queue_free()
	item = null

	for component in cached_components:
		entity.add_child(component)
		entity.components[component.TYPE] = component

func drop_item():
	if not item:
		return

	var item_entity: Entity = Entity.new(drop_definition, entity.grid_position)
	item_entity.components.get(cpnt.ITEM).item = item

	_unequip_item()

	Map.entities.add_child(item_entity)
