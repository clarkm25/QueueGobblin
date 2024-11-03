extends Node2D

@export var food_dict : Dictionary

signal points_gained(num, item)

@onready var scorelabel = $StaticBody2D/PanelContainer/VBoxContainer/Panel/VBoxContainer/ScoreLabel
var score := 0
var score_threshhold := 120
var rolling := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	points_gained.connect(_point_popup)
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("item_resource"):
		var item = body.get_meta("item_resource")
		points_gained.emit(item.value, item.name)
	
func _check_for_pairs():
	var invent : Array[InventoryItem] = ItemPasser.passed_inventory
	
	if invent.is_empty():
		scorelabel.text += "really showing your lack of life-skills here, \nmr. \"bread sandwich\""
		return
	
	var pb := false
	var gamejam := false
	var morito := false
	var mountdoo := false
	var lunchmeat := false
	var lettuce := false
	var laundrypod := false
	var mootpocket := false
	
	var laundrypod_count = 0
	
	for item in invent:
		match item.name:
			"PeanutButter":
				pb = true
			"GameJam":
				gamejam = true
			"Moritos":
				morito = true
			"MountDoo":
				mountdoo = true
			"Lettuce":
				lettuce = true
			"LunchMeat":
				lunchmeat = true
			"LaundryPod":
				laundrypod = true
				laundrypod_count += 1
			"MootPocket":
				mootpocket = true
	
	# food combos
	if pb and gamejam:
		points_gained.emit(30, "THE CLASSIC COMBO!")
	if morito and mountdoo:
		points_gained.emit(20, "GAMER FUEL AND MICROPLASTICS!")
	if lunchmeat and lettuce:
		points_gained.emit(30, "AN ACTUAL SANDWICH!")
	if laundrypod_count >= 3:
		points_gained.emit(100*laundrypod_count, "THE FORBIDDEN FRUIT!")
	elif laundrypod:
		points_gained.emit(-5, "THAT CAN'T BE HEALTHY!")


func _point_popup(pts, title):
	scorelabel.text += title + ": +" + str(pts) + "\n"
	score += pts

func _on_combo_timer_timeout() -> void:
	_check_for_pairs()
	%SCORETOT.text = str(score)
	if score < score_threshhold:
		%OUTCOME.show()
		rolling = true
	else:
		%nextbutton.show()
	%PanelContainer.z_index = 7
	$StaticBody2D/PanelContainer/VBoxContainer/Panel/VBoxContainer/Label2.hide()
	ItemPasser.passed_inventory.clear()
	


func _process(_delta):
	if rolling:
		%LPNUM.text = str(randi_range(0, 80))


func _on_roll_button_pressed() -> void:
	rolling = false
	$StaticBody2D/PanelContainer/VBoxContainer/Panel/VBoxContainer/OUTCOME/Button.hide()
	score += int(%LPNUM.text)
	%SCORETOT.text = str(score)
	%nextbutton.show()	


func _on_nextbutton_pressed() -> void:
	if score >= score_threshhold:
		get_tree().change_scene_to_file("res://scenes/menus/end/end_menu_dub.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/menus/end/end_menu_loss.tscn")
