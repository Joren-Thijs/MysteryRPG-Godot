class_name Tab extends Panel

var selected := false

var hovered := false
@export var hoverColor: Color

func _ready() -> void:
    focus_entered.connect(on_hover)
    mouse_entered.connect(on_hover)
    focus_exited.connect(on_unhover)
    mouse_exited.connect(on_unhover)
    
func _process(delta: float) -> void:
    set_color()

func lighten() -> void:
    modulate = hoverColor

func set_color() -> void:
    if hovered:
        lighten()
    elif selected:
        modulate = Color("ffffff")
    else:
        darken()

func darken() -> void:
    modulate = Color("cecece")

func on_hover() -> void:
    hovered = true

func on_unhover() -> void:
    hovered = false
