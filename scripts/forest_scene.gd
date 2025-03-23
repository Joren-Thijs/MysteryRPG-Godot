extends Node2D

@onready var jeffrey: Jeffrey = %Jeffrey
@onready var walk_away_target: Node2D = %"Walk away target"

func _ready() -> void:
	MusicManager.play_music.emit(Music.Songs.FOREST_SCENE)
	
func walk_away_jeffrey() -> void:
	jeffrey.update_navigation_target(walk_away_target)

func _on_jeffrey_player_invited() -> void:
	print("player invited")
	walk_away_jeffrey()
