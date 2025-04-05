class_name Villa extends Node2D

@onready var player: Player = $Player
@onready var villa_bottom_floor: VillaBottomFloor = $VillaBottomFloor
@onready var villa_top_floor: VillaTopFloor = $VillaTopFloor
@onready var garden: Node2D = $Garden
@onready var garden_shed: Node2D = $GardenShed

func _ready() -> void:
    villa_bottom_floor.player_entered_staircase_to_top_floor.connect(travel_to_top_floor_from_bottom_floor.bind(player))
    villa_top_floor.player_entered_staircase_to_bottom_floor.connect(travel_to_bottom_floor_from_top_floor.bind(player))
    travel_to_bottom_floor_from_top_floor(player)

func travel_to_top_floor_from_bottom_floor(player: Player) -> void:
    villa_top_floor.travel_to_from_bottom_staircase(player)
    
func travel_to_bottom_floor_from_top_floor(player: Player) -> void:
    villa_bottom_floor.travel_to_from_top_staircase(player)
    
func travel_to_garden_from_bottom_floor(player: Player) -> void:
    pass
    
func travel_to_garden_from_garden_shed(player: Player) -> void:
    pass

func travel_to_garden_shed_from_garden(player: Player) -> void:
    pass
