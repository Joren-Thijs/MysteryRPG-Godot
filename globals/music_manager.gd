extends Node

@onready var music_player: AudioStreamPlayer2D = $MusicPlayer

const MAINMENUSONG = preload("res://sound/music/Mainmenusong.mp3")
const OPENING_FOREST_SOUND = preload("res://sound/music/openingForestSound.mp3")
const TOAST_SCENE_SOUND = preload("res://sound/music/toastSceneSound.mp3")

signal play_music(music: Music.Songs)

var current_music: Music.Songs

func _ready() -> void:
    play_music.connect(play)

func play(music: Music.Songs):
    
    if music == current_music:
        return
    
    var musicToPlay: Resource
    
    match music:
        Music.Songs.MAIN_MENU:
            musicToPlay = MAINMENUSONG
        Music.Songs.FOREST_SCENE:
            musicToPlay = OPENING_FOREST_SOUND
        Music.Songs.TOAST_SCENE:
            musicToPlay = TOAST_SCENE_SOUND
        _:
            return
    
    current_music = music
    music_player.stream = musicToPlay
    music_player.play()
