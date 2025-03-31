class_name Player

extends CharacterBody2D

const BASE_SPEED = 3000.0
const SPRINT_SPEED = 5500
const RAY_CAST_SIZE = 20
var speed = 0
var direction: Vector2 = Vector2.ZERO
var is_talking := false

@export var inventory: Inventory

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast

func _ready() -> void:
    DialogueManager.dialogue_started.connect(on_dialogue_started)
    DialogueManager.dialogue_ended.connect(on_dialogue_ended)

func _physics_process(delta: float) -> void:
    get_movement()
    velocity = direction * speed * delta
    move_and_slide()
    
func get_movement() -> void:
    if is_talking:
        direction = Vector2.ZERO
        animated_sprite.stop()
        return
    
    if Input.is_action_pressed("sprint"):
        speed = SPRINT_SPEED
    else:
        speed = BASE_SPEED
    
    if Input.is_action_pressed("move_up"):
        direction = Vector2(0, -1)
        animated_sprite.play("walk_up")
        ray_cast.target_position = Vector2(0, -RAY_CAST_SIZE)
    elif Input.is_action_pressed("move_down"):
        direction = Vector2(0, 1)
        animated_sprite.play("walk_down")
        ray_cast.target_position = Vector2(0, RAY_CAST_SIZE)
    elif Input.is_action_pressed("move_left"):
        direction = Vector2(-1, 0)
        animated_sprite.play("walk_left")
        ray_cast.target_position = Vector2(-RAY_CAST_SIZE, 0)
    elif Input.is_action_pressed("move_right"):
        direction = Vector2(1, 0)
        animated_sprite.play("walk_right")
        ray_cast.target_position = Vector2(RAY_CAST_SIZE, 0)
    else:
        direction = Vector2.ZERO
        animated_sprite.stop()
        
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("interact") && ray_cast.is_colliding():
        var body = ray_cast.get_collider()
        if body is Character:
            body.interact()
        if body is GameObject:
            body.interact()
            
func on_dialogue_started(resource: DialogueResource) -> void:
    is_talking = true

func on_dialogue_ended(resource: DialogueResource) -> void:
    is_talking = false
