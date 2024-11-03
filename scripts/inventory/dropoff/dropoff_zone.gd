extends Area2D

@onready var timer = $"../GameTimer"
@onready var foodDialog = $FoodDialog

var items : Array[InventoryItem] = []
var droppable : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if droppable == true:
			get_viewport().set_input_as_handled()
			_update_pass_inventory(true)
			get_tree().change_scene_to_file("res://scenes/cooking_mother.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		droppable = true
		_update_pass_inventory(false)
		if ItemPasser.passed_inventory.is_empty():
			foodDialog.text = "I need to make food \nbefore I can rank up"
		else:
			foodDialog.text = "Click e to queue!"
		foodDialog.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		droppable = false
		foodDialog.hide()
		
func _update_pass_inventory(clear : bool):
	items = []
	
	var player_inventory = get_tree().get_first_node_in_group("inventory").inventory
	
	for n in player_inventory.items.size():
		var item = player_inventory.items[n]
		
		if item == null:
			continue
		
		items.append(item)
		if clear:
			player_inventory.remove_by_index(n)
		print("Item added!")
	ItemPasser.passed_inventory = items
