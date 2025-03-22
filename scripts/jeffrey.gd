extends Character

const MOVEMENT_SPEED := 2000
@export var navigation_target: Node2D = null
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var navigation_path_refresh_timer: Timer = $NavigationAgent2D/NavigationPathRefresh

func _ready() -> void:
	if navigation_target != null:
		navigation_agent.target_position = navigation_target.global_position

func _physics_process(delta: float) -> void:
	if navigation_target == null:
		return
	if !navigation_agent.is_target_reached():
		var nav_point_direction = to_local(navigation_agent.get_next_path_position()).normalized()
		velocity = nav_point_direction * MOVEMENT_SPEED * delta
		
		
		
		move_and_slide()

func talk():
	DialogManager.display_dialogue.emit("Hello Sam!")

func _on_navigation_path_refresh_timeout() -> void:
	if navigation_target == null:
		return
	if navigation_agent.target_position != navigation_target.global_position:
		navigation_agent.target_position = navigation_target.global_position
	navigation_path_refresh_timer.start()
