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
	if starting_item: equip_item(starting_item.get_item())

func equip_item(new_item: Item) -> int:
	if item:
		return 0

	item = new_item
	for component in item.components:
		var base_component: Component = entity.components.get(component.TYPE)
		if base_component:
			cached_components += [base_component]
			entity.remove_child(base_component)

		entity.add_child(component)
		entity.components[component.TYPE] = component

	return delay

func _unequip_item():
	for component in item.components:
		entity.components.erase(component.TYPE)
		entity.remove_child(component)
	item = null

	for component in cached_components:
		cached_components.erase(component)
		entity.components[component.TYPE] = component
		entity.add_child(component)

func drop_item():
	if not item:
		return

	var item_entity: Entity = Entity.new(drop_definition, entity.grid_position)
	item_entity.components.get(cpnt.ITEM).item = item

	_unequip_item()

	Initiative.add_entity(item_entity)
