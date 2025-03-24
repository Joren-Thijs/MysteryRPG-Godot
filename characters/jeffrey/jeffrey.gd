class_name Jeffrey

extends Character

signal player_invited()
const dialogue = preload("res://characters/jeffrey/invitation.dialogue")
func talk():
	DialogueManager.show_dialogue_balloon(dialogue, "start")

func _on_navigation_agent_navigation_finished() -> void:
	talk()
	player_invited.emit()
	
