extends Node2D

@export var possible_resources : Array[InventoryItem]

@export_range(0, 1, 0.01) var chance_to_spawn : float

var ground_item : PackedScene = preload("res://scenes/inventory/ground_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_spawn = randf_range(0, 1)
	
	if random_spawn <= chance_to_spawn:
		var resource = possible_resources.pick_random()
		var ground = ground_item.instantiate()
		
		ground.item_resource = resource
		
		add_child(ground)
