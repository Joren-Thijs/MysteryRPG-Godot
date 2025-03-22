extends Character

func talk():
	DialogManager.display_dialogue.emit("Hello Player")
