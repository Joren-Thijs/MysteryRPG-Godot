extends GameObject

@export var destination: PackedScene = null

func interact():
	print("I am a door")
	if destination!= null:
		SceneManager.goto_scene(destination)
