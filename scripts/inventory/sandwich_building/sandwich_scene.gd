extends Node2D

@export var food_dict : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var counter = 1
	for item in ItemPasser.passed_inventory:
		if food_dict.has(item.name):
			var rb_object : PackedScene = food_dict[item.name]
			var instance = rb_object.instantiate()
			if counter == 1:
				$Ingredient1Location.add_child(instance)
			elif counter == 2:
				$Ingredient2Location.add_child(instance)
			elif counter == 3:
				$Ingredient3Location.add_child(instance)
			counter += 1
	
	ItemPasser.passed_inventory.clear()
	
