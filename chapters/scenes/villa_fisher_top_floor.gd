class_name VillaTopFloor extends Node2D

signal player_entered_staircase_to_bottom_floor()

@onready var staircase_to_bottom_floor: TeleportZone = %StaircaseToBottomFloor
@onready var staircase_marker: PlayerSpawnMarker = $"Y-sort/StaircaseMarker"

func _ready() -> void:
    staircase_to_bottom_floor.player_entered.connect(on_player_entered_staircase_to_bottom_floor)

func travel_to_from_bottom_staircase(player: Player) -> void:
    staircase_marker.move_player(player)

func on_player_entered_staircase_to_bottom_floor() -> void:
    print("player entered staircase")
    player_entered_staircase_to_bottom_floor.emit()
