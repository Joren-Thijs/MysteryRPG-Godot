class_name VillaBottomFloor extends Node2D

@onready var staircase_to_top_floor: TeleportZone = %StaircaseToTopFloor
@onready var garden_door: Door = $"Y-sort/Hallways/GardenDoor"
@onready var basement_door: Door = $"Y-sort/Pantry/BasementDoor"

@onready var basement_door_marker: PlayerSpawnMarker = $"Y-sort/Hallways/BasementDoorMarker"
@onready var staircase_marker: PlayerSpawnMarker = $"Y-sort/Hallways/StaircaseMarker"
@onready var garden_door_marker: PlayerSpawnMarker = $"Y-sort/Hallways/GardenDoorMarker"

signal player_entered_staircase_to_top_floor()
signal player_uses_door_to_garden()
signal player_uses_door_to_basement()

func _ready() -> void:
    staircase_to_top_floor.player_entered.connect(_on_player_entered_staircase_to_top_floor)
    garden_door.player_uses_door.connect(_player_uses_door_to_garden)
    basement_door.player_uses_door.connect(_player_uses_door_to_basement)

func travel_to_from_basement(player: Player) -> void:
    basement_door_marker.move_player(player)
    SoundManager.play_close_door()

func travel_to_from_top_staircase(player: Player) -> void:
    staircase_marker.move_player(player)

func travel_to_from_garden(player: Player) -> void:
    garden_door_marker.move_player(player)
    SoundManager.play_close_door()

func _on_player_entered_staircase_to_top_floor() -> void:
    print("player entered staircase")
    player_entered_staircase_to_top_floor.emit()

func _player_uses_door_to_garden() -> void:
    print("player uses garden door")
    player_uses_door_to_garden.emit()

func _player_uses_door_to_basement() -> void:
    print("player uses garden door")
    player_uses_door_to_basement.emit()
