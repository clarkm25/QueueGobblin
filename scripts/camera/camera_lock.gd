extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player

var target_pos = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	target_pos = player.global_position
	
	for room in get_tree().get_nodes_in_group("room"):
		room.capture.connect(set_camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.global_position.y > (8*16) and player.global_position.y < (13*16):
		target_pos.x = player.global_position.x
	
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "global_position", target_pos, 0.25)


func set_camera(room : Node2D):
	target_pos = room.global_position
