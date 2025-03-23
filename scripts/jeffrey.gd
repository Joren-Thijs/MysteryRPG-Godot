extends Character

const MOVEMENT_SPEED := 2000

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var direction: Vector2 = Vector2.ZERO

@export var navigation_target: Node2D = null
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var navigation_path_refresh_timer: Timer = $NavigationAgent2D/NavigationPathRefresh

func _ready() -> void:
	if navigation_target != null:
		navigation_agent.target_position = navigation_target.global_position
		
func _physics_process(delta: float) -> void:
	get_movement()
	velocity = direction * MOVEMENT_SPEED * delta
	#print("moving with direction ", direction)
	move_and_slide()

func get_movement() -> void:
	if navigation_target == null:
		direction = Vector2.ZERO
		animated_sprite.stop()
		return
	if !navigation_agent.is_target_reached():
		direction = to_local(navigation_agent.get_next_path_position()).normalized()
		
		var horizontal = abs(direction.x) > abs(direction.y)
		
		if !horizontal and direction.y < 0:
			animated_sprite.play("walk_up")
		elif !horizontal and direction.y > 0:
			animated_sprite.play("walk_down")
		elif horizontal and direction.x < 0:
			animated_sprite.play("walk_left")
		elif horizontal and direction.x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.stop()
		
		move_and_slide()
	else:
		direction = Vector2.ZERO
		animated_sprite.stop()
	if !navigation_agent.is_target_reachable():
		direction = Vector2.ZERO
		animated_sprite.stop()

func talk():
	DialogManager.display_dialogue.emit("Hello Sam!")

func _on_navigation_path_refresh_timeout() -> void:
	if navigation_target == null:
		return
	if navigation_agent.target_position != navigation_target.global_position:
		navigation_agent.target_position = navigation_target.global_position
	navigation_path_refresh_timer.start()

func _on_navigation_agent_2d_navigation_finished() -> void:
	talk()
	navigation_target = null
