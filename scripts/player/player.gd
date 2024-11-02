extends CharacterBody2D

@export var move_speed = 300.0

func _ready():
	$AnimationPlayer.play("idle_down")

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up", "move_down")
	if direction:
		velocity = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x,0,move_speed)
		velocity.y = move_toward(velocity.y,0,move_speed)
		
	move_and_slide()
	
	if direction.x == 0 and direction.y == 0:
		$AnimationPlayer.seek(0.9, true) # the standing pose of current animation
	
	if direction.x > 0:
		$AnimationPlayer.play("walk_right")
	elif direction.x < 0:
		$AnimationPlayer.play("walk_left")
	elif direction.y < 0:
		$AnimationPlayer.play("walk_up")
	elif direction.y > 0:
		$AnimationPlayer.play("walk_down")
