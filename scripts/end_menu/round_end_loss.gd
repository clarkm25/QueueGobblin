extends Control


# Called when the node enters the scene tree for the first time.

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
