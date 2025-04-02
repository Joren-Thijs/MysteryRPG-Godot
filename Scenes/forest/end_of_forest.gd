extends Area2D

func _on_body_entered(body: Node2D) -> void:
    var player := body as Player
    if not player:
        return
    
    SceneManager.load_new_chapter(SceneManager.Chapter.TOAST_SCENE)
