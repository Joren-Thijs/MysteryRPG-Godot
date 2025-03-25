class_name Character
extends CharacterBody2D

@export var movement_speed: int = 3000
var direction: Vector2 = Vector2.ZERO

@export var initial_dialogue : DialogueResource
var current_dialogue: DialogueResource

@export var navigation_target: Node2D
		
@onready var character_navigation_agent: NavigationAgent2D = $CharacterNavigationAgent

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
		
func _ready() -> void:
	current_dialogue = initial_dialogue
	set_navigation_target(navigation_target)
	
func _physics_process(delta: float) -> void:
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
	
	velocity = direction * movement_speed * delta
	move_and_slide()

func set_navigation_target(target: Node2D = null, callback: Callable = Callable()):
	navigation_target = target
	character_navigation_agent.set_navigation_target(navigation_target, callback)

func set_dialogue(dialogue: DialogueResource):
	current_dialogue = dialogue

func interact() -> void:
	talk()

func talk() -> void:
	pass
