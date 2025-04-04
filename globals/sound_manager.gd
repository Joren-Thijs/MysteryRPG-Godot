extends Node

@onready var sound_effect_player: AudioStreamPlayer2D = $SoundEffectPlayer
@onready var sound_effect_timer: Timer = $SoundEffectTimer

const RUSTLE_PAPER = preload("res://sound/effects/rustle_paper.mp3")
const NOTE_SCRIBBLE = preload("res://sound/effects/note_scribble.mp3")
const PICKUP_ITEM = preload("res://sound/effects/pickup_item.mp3")
const DOOR = preload("res://sound/effects/door.mp3")

func play_from_until(sound: Resource, start: float, end: float = 0) -> void:
    sound_effect_player.stream = sound
    sound_effect_player.play(start)
    if end > 0:
        assert(start < end, "ERROR: Sound effect end must be after start")
        sound_effect_timer.start(end - start)

func play_open_notebook()-> void:
    play_from_until(RUSTLE_PAPER, 4.2, 5.2)

func play_note_added()-> void:
    play_from_until(NOTE_SCRIBBLE, 0, 0.65)

func play_item_added()-> void:
    play_from_until(PICKUP_ITEM, 0.08)
    
func play_open_door()-> void:
    play_from_until(DOOR, 0, 2)
    
func play_close_door()-> void:
    play_from_until(DOOR, 2.75)

func _on_sound_effect_timer_timeout() -> void:
    sound_effect_player.stop()
