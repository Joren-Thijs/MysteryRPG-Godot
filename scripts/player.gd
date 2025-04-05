class_name Player extends CharacterBody2D

const BASE_SPEED = 3000.0
const SPRINT_SPEED = 5500
const RAY_CAST_SIZE = 20
var speed = 0
var direction: Vector2 = Vector2.ZERO
var dialogue_or_transition_in_progress := false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast

func _ready() -> void:
    DialogueManager.dialogue_started.connect(on_dialogue_or_transition_started)
    DialogueManager.dialogue_ended.connect(on_dialogue_or_transition_ended)
    SceneManager.fade_in_started.connect(on_dialogue_or_transition_started)
    SceneManager.fade_in_finished.connect(on_dialogue_or_transition_ended)
    SceneManager.fade_out_started.connect(on_dialogue_or_transition_started)
    SceneManager.fade_out_finished.connect(on_dialogue_or_transition_ended)

func _physics_process(delta: float) -> void:
    _get_movement()
    _handle_animation()
    velocity = direction * speed * delta
    move_and_slide()
    
func _handle_animation() -> void:
    if direction == Vector2.UP:
        animated_sprite.play("walk_up")
        ray_cast.target_position = Vector2(0, -RAY_CAST_SIZE)
    if direction == Vector2.DOWN:
        animated_sprite.play("walk_down")
        ray_cast.target_position = Vector2(0, RAY_CAST_SIZE)
    if direction == Vector2.LEFT:
        animated_sprite.play("walk_left")
        ray_cast.target_position = Vector2(-RAY_CAST_SIZE, 0)
    if direction == Vector2.RIGHT:
        animated_sprite.play("walk_right")
        ray_cast.target_position = Vector2(RAY_CAST_SIZE, 0)
    if speed == 0:
        animated_sprite.stop()
        
func _get_movement() -> void:
    if dialogue_or_transition_in_progress or InventoryManager.is_open:
        speed = 0
        return
    
    if Input.is_action_pressed("sprint"):
        speed = SPRINT_SPEED
    else:
        speed = BASE_SPEED
    
    if Input.is_action_pressed("move_up"):
        direction = Vector2(0, -1)
    elif Input.is_action_pressed("move_down"):
        direction = Vector2(0, 1)
    elif Input.is_action_pressed("move_left"):
        direction = Vector2(-1, 0)
    elif Input.is_action_pressed("move_right"):
        direction = Vector2(1, 0)
    else:
        speed = 0
        
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("interact") and ray_cast.is_colliding() and !dialogue_or_transition_in_progress:
        var body = ray_cast.get_collider()
        if body is Character:
            body.interact()
        if body is GameObject:
            body.interact()
            
func on_dialogue_or_transition_started(resource: DialogueResource) -> void:
    dialogue_or_transition_in_progress = true

func on_dialogue_or_transition_ended(resource: DialogueResource) -> void:
    dialogue_or_transition_in_progress = false
