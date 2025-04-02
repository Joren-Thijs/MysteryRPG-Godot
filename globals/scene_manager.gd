extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const MAIN_MENU = preload("res://scenes/MainMenu.tscn")
const FOREST_SCENE = preload("res://scenes/forest/forest_scene.tscn")
const TOAST_SCENE = preload("res://scenes/toast/toast_scene.tscn")

enum Chapter {
    MAIN_MENU,
    FOREST_SCENE,
    TOAST_SCENE
}

var current_scene: Node = null

func _ready():
    # Load the main menu scene when the game starts
    load_new_scene(TOAST_SCENE)
    
func load_first_chapter() -> void:
    load_new_scene(FOREST_SCENE)
    animation_player.play("scene_fade_in")
    await animation_player.animation_finished

func load_new_chapter(chapter: Chapter) -> void:
    animation_player.play("scene_fade_out")
    await animation_player.animation_finished
    match chapter:
        Chapter.MAIN_MENU:
            load_new_scene(MAIN_MENU)
        Chapter.FOREST_SCENE:
            load_new_scene(FOREST_SCENE)
        Chapter.TOAST_SCENE:
            load_new_scene(TOAST_SCENE)
    animation_player.play("scene_fade_in")
    await animation_player.animation_finished

func load_new_scene(scene: PackedScene) -> void:
    # Use call_deferred to defer the scene transition to the next frame.
    call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene: PackedScene) -> void:
    # Get the current scene and set it as the new current scene.
    get_tree().change_scene_to_packed(scene)
