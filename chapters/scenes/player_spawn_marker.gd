class_name PlayerSpawnMarker extends Node2D

@export var direction: Vector2 = Vector2.DOWN
@export var is_door: bool = false

func move_player(player: Player) -> void:
    player.reparent(self)
    player.position = Vector2.ZERO
    player.direction = direction
    if is_door:
        SoundManager.play_close_door()
