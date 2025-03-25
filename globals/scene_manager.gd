extends Node

const MAIN_MENU = preload("res://scenes/MainMenu.tscn")
const FOREST_SCENE = preload("res://scenes/forest_scene.tscn")

enum Chapter {
	MAIN_MENU,
	FOREST_SCENE,
}

var current_scene: Node = null

func _ready():
	# Load the main menu scene when the game starts
	load_new_scene(Chapter.FOREST_SCENE)

func load_new_scene(chapter: Chapter):
	match chapter:
		Chapter.MAIN_MENU:
			goto_scene(MAIN_MENU)
		Chapter.FOREST_SCENE:
			goto_scene(FOREST_SCENE)

func goto_scene(scene: PackedScene):
	# Use call_deferred to defer the scene transition to the next frame.
	call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene: PackedScene):
	# Get the current scene and set it as the new current scene.
	get_tree().change_scene_to_packed(scene)
