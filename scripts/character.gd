class_name Character
extends CharacterBody2D

@export var movement_speed: int = 3000
var direction: Vector2 = Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	setup_navigation()
		
func _physics_process(delta: float) -> void:
	get_movement()
	velocity = direction * movement_speed * delta
	move_and_slide()
	
#region navigation
@export var navigation_target: Node2D = null
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
var is_navigating: bool:
	get: return navigation_target != null
@onready var navigation_path_refresh_timer: Timer = $NavigationAgent2D/NavigationPathRefresh

func setup_navigation() -> void:
	navigation_agent.navigation_finished.connect(_on_navigation_agent_navigation_finished)
	navigation_path_refresh_timer.timeout.connect(_on_navigation_path_refresh_timeout)
	if is_navigating:
		navigation_agent.target_position = navigation_target.global_position

func set_navigation_target(node: Node2D) -> void:
	navigation_target = node

func get_movement() -> void:
	if !is_navigating:
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
	else:
		direction = Vector2.ZERO
		animated_sprite.stop()
	if !navigation_agent.is_target_reachable():
		direction = Vector2.ZERO
		animated_sprite.stop()

func _on_navigation_agent_navigation_finished() -> void:
	pass

func _on_navigation_path_refresh_timeout() -> void:
	if !is_navigating:
		return
	if navigation_agent.target_position != navigation_target.global_position:
		navigation_agent.target_position = navigation_target.global_position
	navigation_path_refresh_timer.start()
#endregion

func interact() -> void:
	talk()

func talk() -> void:
	pass
