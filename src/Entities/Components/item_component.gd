class_name ItemComponent
extends Component

const TYPE = cpnt.ITEM

var item: Item

var starting_item: ItemDefinition

func _init(component_definition: ItemComponentDefinition):
	starting_item = component_definition.item_definition
	if starting_item: item = starting_item.get_item()

func _ready():
	entity.ready.connect(entity_ready)

func entity_ready():
	entity.z_index = -1
	entity.texture = item.texture
