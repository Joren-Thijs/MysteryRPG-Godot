extends Node

@onready var music_player: AudioStreamPlayer2D = $MusicPlayer

const MAINMENUSONG = preload("res://Sound/Mainmenusong.mp3")
const OPENING_FOREST_SOUND = preload("res://Sound/openingForestSound.mp3")

signal play_music(music: Music.Songs)

func _ready() -> void:
	play_music.connect(play)

func play(music: Music.Songs):
	var musicToPlay: Resource
	
	match music:
		Music.Songs.MAIN_MENU:
			musicToPlay = MAINMENUSONG
		Music.Songs.FOREST_SCENE:
			musicToPlay = OPENING_FOREST_SOUND
		_:
			return

	music_player.stream = musicToPlay
	music_player.play()
