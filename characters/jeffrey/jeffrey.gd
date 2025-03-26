class_name Jeffrey

extends Character

signal player_invited()

func _ready() -> void:
	super()
	set_navigation_target(navigation_target, talk)

func talk():
	if current_dialogue != null:
		DialogueManager.show_dialogue_balloon(current_dialogue, "start")
