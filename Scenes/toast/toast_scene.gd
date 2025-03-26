extends Node2D

func _ready() -> void:
	MusicManager.play_music.emit(Music.Songs.TOAST_SCENE)
