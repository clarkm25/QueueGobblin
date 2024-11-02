extends Node

var inventory : Inventory
var ground_item_scene = preload("res://scenes/inventory/ground_item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory = get_tree().get_first_node_in_group("inventory").inventory

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("first_inventory_slot"):
		drop_item(0)
	elif Input.is_action_just_pressed("second_inventory_slot"):
		drop_item(1)
	elif Input.is_action_just_pressed("third_inventory_slot"):
		drop_item(2)

func drop_item(item_index: int):
	if inventory.get_item_by_index(item_index) != null:
		var ground_item = ground_item_scene.instantiate()
		
		ground_item.position = get_tree().get_first_node_in_group("player").position
		ground_item.item_resource = inventory.get_item_by_index(item_index)
		
		get_tree().current_scene.add_child(ground_item)
		
		inventory.remove_by_index(item_index)
	else:
		print("No item to drop")
