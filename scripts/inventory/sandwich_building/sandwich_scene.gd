extends Node2D

@export var food_dict : Dictionary

signal points_gained(num, item)

@onready var scorelabel = $StaticBody2D/PanelContainer/VBoxContainer/Panel/VBoxContainer/ScoreLabel
var score := 0
var score_threshhold := 160
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
	
	if pb and gamejam:
		points_gained.emit(20, "THE CLASSIC COMBO!")
	if morito and mountdoo:
		points_gained.emit(20, "GAMER FUEL AND MICROPLASTICS!")

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
