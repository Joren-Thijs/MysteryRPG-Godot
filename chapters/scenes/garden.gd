class_name Garden extends Node2D

@onready var shed_door: Door = $"Y-sort/GardenObjects/ShedDoor"
@onready var house_door: Door = $"Y-sort/GardenObjects/HouseDoor"

@onready var house_door_marker: PlayerSpawnMarker = $"Y-sort/GardenObjects/HouseDoorMarker"
@onready var garden_shed_door_marker: PlayerSpawnMarker = $"Y-sort/GardenObjects/GardenShedDoorMarker"

signal player_uses_door_to_garden_shed()
signal player_uses_door_to_villa_bottom_floor()

func _ready() -> void:
    house_door.player_uses_door.connect(_player_uses_door_to_villa_bottom_floor)
    shed_door.player_uses_door.connect(_player_uses_door_to_garden_shed)

func travel_to_from_house(player: Player):
    house_door_marker.move_player(player)
    SoundManager.play_close_door()
    
func travel_to_from_garden_shed(player: Player):
    garden_shed_door_marker.move_player(player)
    SoundManager.play_close_door()

func _player_uses_door_to_garden_shed() -> void:
    print("player uses garden shed door")
    player_uses_door_to_garden_shed.emit()

func _player_uses_door_to_villa_bottom_floor() -> void:
    print("player uses house door")
    player_uses_door_to_villa_bottom_floor.emit()
