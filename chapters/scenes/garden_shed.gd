class_name GardenShed extends Node2D
@onready var shed_door: Door = $"Y-sort/GardenShedObjects/ShedDoor"
@onready var garden_shed_door_marker: PlayerSpawnMarker = $"Y-sort/GardenShedObjects/GardenShedDoorMarker"

signal player_uses_door_to_garden()

func _ready() -> void:
    shed_door.player_uses_door.connect(_player_uses_door_to_garden)

func travel_to_from_garden(player: Player):
    garden_shed_door_marker.move_player(player)

func _player_uses_door_to_garden() -> void:
    print("player uses garden shed door")
    player_uses_door_to_garden.emit()
