class_name Villa extends Node2D

@onready var player: Player = $Player
@onready var villa_bottom_floor: VillaBottomFloor = $VillaBottomFloor
@onready var villa_top_floor: VillaTopFloor = $VillaTopFloor
@onready var garden: Garden = $Garden
@onready var garden_shed: GardenShed = $GardenShed

func _ready() -> void:
    villa_bottom_floor.player_entered_staircase_to_top_floor.connect(travel_to_top_floor_from_bottom_floor)
    villa_bottom_floor.player_uses_door_to_garden.connect(travel_to_garden_from_bottom_floor)
    villa_bottom_floor.player_uses_door_to_basement.connect(travel_to_basement_from_bottom_floor)
    
    villa_top_floor.player_entered_staircase_to_bottom_floor.connect(travel_to_bottom_floor_from_top_floor)
    
    garden.player_uses_door_to_villa_bottom_floor.connect(travel_to_bottom_floor_from_garden)
    garden.player_uses_door_to_garden_shed.connect(travel_to_garden_shed_from_garden)
    
    garden_shed.player_uses_door_to_garden.connect(travel_to_garden_from_garden_shed)
    
    villa_bottom_floor.travel_to_from_garden(player)

func travel_to_top_floor_from_bottom_floor() -> void:
    _travel(villa_top_floor.travel_to_from_bottom_staircase)
    
func travel_to_bottom_floor_from_top_floor() -> void:
    _travel(villa_bottom_floor.travel_to_from_top_staircase)
    
func travel_to_bottom_floor_from_garden() -> void:
    _travel(villa_bottom_floor.travel_to_from_garden)
    
func travel_to_garden_from_bottom_floor() -> void:
    _travel(garden.travel_to_from_house)
    
func travel_to_garden_from_garden_shed() -> void:
    _travel(garden.travel_to_from_garden_shed)

func travel_to_garden_shed_from_garden() -> void:
    _travel(garden_shed.travel_to_from_garden)

func travel_to_basement_from_bottom_floor() -> void:
    pass

func _travel(callable: Callable) -> void:
    if callable.is_valid():
        await SceneManager.fade_out()
        callable.call(player)
        SceneManager.fade_in()
