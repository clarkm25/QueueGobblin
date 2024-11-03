extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($volume_slider.value))
	$volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro_scene.tscn")


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($volume_slider.value))
