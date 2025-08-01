class_name WieldComponent
extends Component

const TYPE = cpnt.WIELD

signal item_changed

var item: Item:
	set(value):
		item = value
		item_changed.emit()

var cached_components: Array[Component]
var starting_item: ItemDefinition

func _init(component_definition: WieldComponentDefinition):
	starting_item = component_definition.item_definition

func _ready():
	entity.ready.connect(entity_ready)

func entity_ready():
	if starting_item: equip_item(starting_item)

func equip_item(item_definition: ItemDefinition):
	assert(not item)

	item = item_definition.get_item()
	for component in item.components:
		var base_component: Component = entity.components.get(component.TYPE)
		if base_component:
			cached_components += [base_component]
			base_component.queue_free()

		entity.add_child(component)
		entity.components[component.TYPE] = component

func _unequip_item():
	for component in item.components:
		entity.components.erase(component.TYPE)
		component.queue_free()
	item = null

	for component in cached_components:
		entity.add_child(component)
		entity.components[component.TYPE] = component
