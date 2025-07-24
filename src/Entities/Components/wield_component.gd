class_name WieldComponent
extends Component

var item: Item
var cached_components: Array[Component]
var starting_item: ItemDefinition

func _init(component_definition: WieldComponentDefinition):
	name = "WieldComponent"
	starting_item = component_definition.item_definition

func _ready():
	entity.ready.connect(entity_ready)

func entity_ready():
	equip_item(starting_item)

func equip_item(item_definition: ItemDefinition):
	assert(not item)

	item = item_definition.get_item()
	for component in item.components:
		var base_component: Component = entity.components.get(component.name)
		if base_component:
			cached_components += [base_component]
			entity.remove_child(base_component)

		entity.add_child(component)
		entity.components[component.name] = component

func unequip_item():
	for component in item.components:
		entity.components.erase(component.name)
		component.queue_free()
	item = null

	for component in cached_components:
		entity.add_child(component)
		entity.components[component.name] = component
