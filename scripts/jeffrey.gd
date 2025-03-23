class_name Jeffrey

extends Character

signal player_invited()

func talk():
	DialogManager.display_dialogue.emit("Hello Sam!")

func on_navigation_agent_navigation_finished() -> void:
	talk()
	player_invited.emit()
	
