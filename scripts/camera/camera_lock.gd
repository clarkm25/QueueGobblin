extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player
@onready var timer = $GameTimer
@onready var clock = $CanvasLayer/Clock/NinePatchRect/Seconds

var target_pos = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Camera locking setup
	target_pos = player.global_position
	for room in get_tree().get_nodes_in_group("room"):
		room.capture.connect(set_camera)
	
	# Game timer setup
	timer.one_shot = true
	timer.autostart = false
	timer.wait_time = 20 # Duration of game phase
	timer.start()


func _process(delta: float) -> void:
	# Camera follows player through the hallway
	if player.global_position.y > (8*16) and player.global_position.y < (13*16):
		target_pos.x = player.global_position.x
	# Camera tween when switching between camera locks
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "global_position", target_pos, 0.25)
	
	# Update clock hud
	clock.text = str(round($GameTimer.time_left))


func set_camera(room : Node2D):
	target_pos = room.global_position


func _on_game_timer_timeout() -> void:
	# temp functionality of the timer
	print("YOU LOSE SCRUB!")
	get_tree().change_scene_to_file("res://scenes/menus/end/end_menu_loss.tscn")
