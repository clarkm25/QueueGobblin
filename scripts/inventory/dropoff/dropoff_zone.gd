extends Area2D

@onready var timer = $"../GameTimer"

var items : Array[InventoryItem] = []
var droppable : bool = false

var dub_menu := preload("res://scenes/menus/end/end_menu_dub.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if droppable == true:
			timer.stop()
			
			# temporary win condition
			var dub_menu := preload("res://scenes/menus/end/end_menu_dub.tscn")
			
			var player_inventory = get_tree().get_first_node_in_group("inventory").inventory
		
			for n in player_inventory.items.size():
				var item = player_inventory.items[n]
				
				if item == null:
					continue
				
				items.append(item)
				player_inventory.remove_by_index(n)
				print("Item added!")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		droppable = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		droppable = false
