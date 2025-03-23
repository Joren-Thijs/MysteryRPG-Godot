extends Control

@onready var display: RichTextLabel = $Background/Display

var isDisplyingText : bool :
	get: return isDisplyingText
	set(value):
		isDisplyingText = value
		visible = value

func _ready() -> void:
	isDisplyingText = false
	DialogManager.display_dialogue.connect(display_dialogue)
	
func display_dialogue(dialogue: String):
	isDisplyingText = true
	display.text = dialogue
	
func _input(event: InputEvent) -> void:
	if isDisplyingText and event.is_action_pressed("ui_accept"):
		end_dialogue()	
	
func end_dialogue() -> void:
	isDisplyingText = false
