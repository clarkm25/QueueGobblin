extends Node2D

@onready var camera_capture = $CameraCapture

signal capture
signal release

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_camera_capture_area_entered(area: Area2D) -> void:
	emit_signal("capture", self)
