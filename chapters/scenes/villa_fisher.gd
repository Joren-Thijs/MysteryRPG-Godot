class_name Villa extends Node2D

@onready var player: Player = $Player
@onready var villa_bottom_floor: VillaBottomFloor = $VillaBottomFloor
@onready var villa_top_floor: VillaTopFloor = $VillaTopFloor
@onready var garden: Garden = $Garden
@onready var garden_shed: GardenShed = $GardenShed

func _ready() -> void:
    villa_bottom_floor.player_entered_staircase_to_top_floor.connect(travel_to_top_floor_from_bottom_floor.bind(player))
    villa_bottom_floor.player_uses_door_to_garden.connect(travel_to_garden_from_bottom_floor.bind(player))
    villa_bottom_floor.player_uses_door_to_basement.connect(travel_to_basement_from_bottom_floor.bind(player))
    
    villa_top_floor.player_entered_staircase_to_bottom_floor.connect(travel_to_bottom_floor_from_top_floor.bind(player))
    
    garden.player_uses_door_to_villa_bottom_floor.connect(travel_to_bottom_floor_from_garden.bind(player))
    garden.player_uses_door_to_garden_shed.connect(travel_to_garden_shed_from_garden.bind(player))
    
    garden_shed.player_uses_door_to_garden.connect(travel_to_garden_from_garden_shed.bind(player))
    
    travel_to_bottom_floor_from_garden(player)

func travel_to_top_floor_from_bottom_floor(player: Player) -> void:
    _travel(villa_top_floor.travel_to_from_bottom_staircase, player)
    
func travel_to_bottom_floor_from_top_floor(player: Player) -> void:
    _travel(villa_bottom_floor.travel_to_from_top_staircase, player)
    
func travel_to_bottom_floor_from_garden(player: Player) -> void:
    _travel(villa_bottom_floor.travel_to_from_garden, player)
    
func travel_to_garden_from_bottom_floor(player: Player) -> void:
    _travel(garden.travel_to_from_house, player)
    
func travel_to_garden_from_garden_shed(player: Player) -> void:
    _travel(garden.travel_to_from_garden_shed, player)

func travel_to_garden_shed_from_garden(player: Player) -> void:
    _travel(garden_shed.travel_to_from_garden, player)

func travel_to_basement_from_bottom_floor(player: Player) -> void:
    pass

func _travel(callable: Callable, player: Player) -> void:
    if callable.is_valid():
        SceneManager.fade_out()
        callable.call(player)
        SceneManager.fade_in()
