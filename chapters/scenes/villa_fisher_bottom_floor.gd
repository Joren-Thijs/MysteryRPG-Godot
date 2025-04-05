class_name VillaBottomFloor extends Node2D

@onready var staircase_to_top_floor: TeleportZone = %StaircaseToTopFloor

@onready var basement_door_marker: PlayerSpawnMarker = $"Y-sort/Hallways/BasementDoorMarker"
@onready var staircase_marker: PlayerSpawnMarker = $"Y-sort/Hallways/StaircaseMarker"
@onready var garden_door_marker: PlayerSpawnMarker = $"Y-sort/Hallways/GardenDoorMarker"

signal player_entered_staircase_to_top_floor()

func _ready() -> void:
    staircase_to_top_floor.player_entered.connect(on_player_entered_staircase_to_top_floor)

func travel_to_from_basement(player: Player) -> void:
    basement_door_marker.move_player(player)

func travel_to_from_top_staircase(player: Player) -> void:
    staircase_marker.move_player(player)

func travel_to_from_garden(player: Player) -> void:
    garden_door_marker.move_player(player)

func on_player_entered_staircase_to_top_floor() -> void:
    print("player entered staircase")
    player_entered_staircase_to_top_floor.emit()
