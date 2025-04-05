class_name PlayerSpawnMarker extends Node2D

@export var direction: Vector2 = Vector2.DOWN

func move_player(player: Player) -> void:
    player.reparent(self)
    player.position = Vector2.ZERO
    player.direction = direction
