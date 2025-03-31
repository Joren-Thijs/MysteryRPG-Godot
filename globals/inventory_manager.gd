extends Control

@onready var notes_tab: Tab = $NotebookBackground/Tabs/NotesTab
@onready var inventory_tab: Tab = $NotebookBackground/Tabs/InventoryTab
@onready var notes: ItemList = $NotebookBackground/Notes
@onready var inventory: ItemList = $NotebookBackground/Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    visible = false
    notes_tab.gui_input.connect(on_notes_tab_gui_input)
    inventory_tab.gui_input.connect(on_inventory_tab_gui_input)
    show_notes()

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("inventory"):
        toggle_visibility()

func toggle_visibility() -> void:
    visible = !visible

func on_notes_tab_gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        show_notes()

func on_inventory_tab_gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        show_inventory()
        
func show_notes() -> void:
    notes_tab.selected = true
    inventory_tab.selected = false
    notes.visible = true
    inventory.visible = false
    
func show_inventory() -> void:
    inventory_tab.selected = true
    notes_tab.selected = false
    inventory.visible = true
    notes.visible = false
