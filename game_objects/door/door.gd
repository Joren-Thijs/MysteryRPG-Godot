extends GameObject

@export var destination: PackedScene = null

func interact():
    print("I am a door")
    if destination!= null:
        SoundManager.play_open_door()
        SceneManager.load_new_scene(destination)
