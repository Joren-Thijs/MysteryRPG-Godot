class_name TeleportZone extends Area2D

signal player_entered()

func _ready() -> void:
    body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D) -> void:
    print("I am a teleporter")
    if body is Player:
        player_entered.emit()
