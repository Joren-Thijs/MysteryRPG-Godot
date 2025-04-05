class_name PlayerSpawnMarker extends Node2D

func move_player(player: Player) -> void:
    player.reparent(self)
    player.position = Vector2.ZERO
