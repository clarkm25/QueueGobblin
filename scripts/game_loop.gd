extends Node2D

var replay_main_scene := preload("res://scenes/level.tscn")
@onready var second_label := $CanvasLayer/Control2/NinePatchRect/Seconds
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameTimer.one_shot = true
	$GameTimer.autostart = false
	$GameTimer.wait_time = 60 # Duration of game phase
	$GameTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	second_label.text = str(round($GameTimer.time_left))
	pass


func _on_game_timer_timeout() -> void:
	# TODO: Show end scene rank up/down plus end game menu instead of
	# reloading the main scene
	replay_main_scene.instantiate()
