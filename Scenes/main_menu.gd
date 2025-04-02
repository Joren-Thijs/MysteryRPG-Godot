extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    MusicManager.play_music.emit(Music.Songs.MAIN_MENU)

func _on_new_game_button_down() -> void:
    SceneManager.load_first_chapter()

func _on_quit_button_down() -> void:
    get_tree().quit()
