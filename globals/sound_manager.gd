extends Node

@onready var sound_effect_player: AudioStreamPlayer2D = $SoundEffectPlayer
@onready var sound_effect_timer: Timer = $SoundEffectTimer

const RUSTLE_PAPER = preload("res://sound/effects/rustle_paper.mp3")
const NOTE_SCRIBBLE = preload("res://sound/effects/note_scribble.mp3")
const PICKUP_ITEM = preload("res://sound/effects/pickup_item.mp3")
const DOOR = preload("res://sound/effects/door.mp3")

func play_open_notebook()-> void:
    sound_effect_player.stream = RUSTLE_PAPER
    sound_effect_player.play(4.2)
    sound_effect_timer.start(1)

func play_note_added()-> void:
    sound_effect_player.stream = NOTE_SCRIBBLE
    sound_effect_player.play()
    sound_effect_timer.start(0.65)

func play_item_added()-> void:
    sound_effect_player.stream = PICKUP_ITEM
    sound_effect_player.play(0.08)
    
func play_open_door()-> void:
    sound_effect_player.stream = DOOR
    sound_effect_player.play()
    sound_effect_timer.start(2)
    
func play_close_door()-> void:
    sound_effect_player.stream = DOOR
    sound_effect_player.play(2.75)

func _on_sound_effect_timer_timeout() -> void:
    sound_effect_player.stop()
