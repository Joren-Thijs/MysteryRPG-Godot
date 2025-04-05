extends Area2D


@export var destination: PackedScene = null

func _ready() -> void:
    body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D) -> void:
    print("I am a teleporter")
    if destination!= null and body is Player:
        SoundManager.play_open_door()
        SceneManager.goto_scene(destination)
