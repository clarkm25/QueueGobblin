extends Control


# Called when the node enters the scene tree for the first time.
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()
	
func _input(event):
	if event.is_action_pressed("pause") and get_tree().paused == false:
		pause()
	elif event.is_action_pressed("pause") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_levels/pause_test_level.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()