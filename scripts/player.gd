extends CharacterBody2D

const BASE_SPEED = 3000.0
const SPRINT_SPEED = 5500
var speed = 0
var direction: Vector2 = Vector2(0,0)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	get_movement()
	velocity = direction * speed * delta
	move_and_slide()
	
func get_movement() -> void:
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = BASE_SPEED
	
	if Input.is_action_pressed("move_up"):
		direction = Vector2(0, -1)
		animated_sprite.play("walk_up")
	elif Input.is_action_pressed("move_down"):
		direction = Vector2(0, 1)
		animated_sprite.play("walk_down")
	elif Input.is_action_pressed("move_left"):
		direction = Vector2(-1, 0)
		animated_sprite.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		direction = Vector2(1, 0)
		animated_sprite.play("walk_right")
	else:
		direction = Vector2(0,0)
		animated_sprite.stop()
		
