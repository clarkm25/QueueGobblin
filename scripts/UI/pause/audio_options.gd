extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($VolumeUI/VolumeSlider.value))
	$VolumeUI/VolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	

func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($VolumeUI/VolumeSlider.value))
