class_name Item
extends RefCounted

var components: Array[Component]
var texture: Texture

func _init(item_definition: ItemDefinition):
	for component in item_definition.components:
		var new_component = component.get_component()
		components += [new_component]

	texture = item_definition.texture
