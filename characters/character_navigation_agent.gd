extends NavigationAgent2D

var character: Character = null

var navigation_target: Node2D = null
var is_navigating: bool:
	get: return navigation_target != null
@onready var navigation_path_refresh_timer: Timer = Timer.new()

var navigation_finished_callback: Callable = Callable()

func _ready() -> void:
	character = get_parent()
	setup_timer()
	setup_navigation()

func setup_timer():
	add_child(navigation_path_refresh_timer)
	navigation_path_refresh_timer.autostart = true
	navigation_path_refresh_timer.one_shot = true
	navigation_path_refresh_timer.wait_time = 1.0
	navigation_path_refresh_timer.timeout.connect(on_navigation_path_refresh_timeout)
	navigation_path_refresh_timer.start(1)

func setup_navigation() -> void:
	navigation_finished.connect(on_navigation_finished)
	if is_navigating:
		target_position = navigation_target.global_position

func set_navigation_target(node: Node2D = null, callback: Callable = Callable()) -> void:
	print("set nav target ", node)
	navigation_target = node
	print("set nav callback ", callback)
	navigation_finished_callback = callback
	
func _physics_process(_delta: float) -> void:
	get_movement()

func get_movement() -> void:
	if !is_navigating:
		character.direction = Vector2.ZERO
		return
	if !is_target_reached():
		character.direction = character.to_local(get_next_path_position()).normalized()
	else:
		character.direction = Vector2.ZERO
	if !is_target_reachable():
		character.direction = Vector2.ZERO

func on_navigation_path_refresh_timeout() -> void:
	if is_navigating:
		if target_position != navigation_target.global_position:
			target_position = navigation_target.global_position
	navigation_path_refresh_timer.start()
	
func on_navigation_finished() -> void:
	if navigation_finished_callback.is_valid():
		navigation_finished_callback.call()
	else:
		print("callback is invalid")
	set_navigation_target()
