extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

var target = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	target = player
	
	for room in get_tree().get_nodes_in_group("room"):
		room.capture.connect(set_camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#camera.set_position(target.position)
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "global_position", target.global_position, 0.25)


func set_camera(room):
	target = room
	
