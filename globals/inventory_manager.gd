extends CanvasLayer

@onready var notes_tab: Tab = $InventoryManagerControl/NotebookBackground/Tabs/NotesTab
@onready var inventory_tab: Tab = $InventoryManagerControl/NotebookBackground/Tabs/InventoryTab
@onready var notes_list: ItemList = $InventoryManagerControl/NotebookBackground/Notes
@onready var inventory_list: ItemList = $InventoryManagerControl/NotebookBackground/Inventory
@onready var note_display: Panel = $InventoryManagerControl/Note
@onready var note_display_text: RichTextLabel = $InventoryManagerControl/Note/Panel/MarginContainer/NoteText

@export var notes: Array[Note]
@export var inventory: Array[InventoryItem]

signal note_added(note: Note)
signal inventory_item_added(item: InventoryItem)

var is_open: bool:
	get:
		return visible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	notes_tab.gui_input.connect(_on_notes_tab_gui_input)
	inventory_tab.gui_input.connect(_on_inventory_tab_gui_input)
	notes_list.item_selected.connect(_on_note_selected)
	inventory_list.item_selected.connect(_on_letter_selected)
	note_display.hide()
	_show_notes()

func _process(delta: float) -> void:
	_render_note_list()
	_render_inventory_list()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		_toggle_visibility()
	if event.is_action_pressed("back"):
		if note_display.visible:
			note_display.hide()
		else:
			hide()
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and note_display.visible:
		note_display.hide()
		
func add_inventory_item(new_item: InventoryItem) -> void:
	if !inventory_has_item(new_item):
		inventory.append(new_item)
		inventory_item_added.emit(new_item)

func add_note(new_note: Note) -> void:
	if !notebook_has_note(new_note):
		notes.append(new_note)
		note_added.emit(new_note)

func inventory_has_item(new_item: InventoryItem) -> bool:
	return inventory.any(func(item): return item.name == new_item.name)
	
func notebook_has_note(new_note: Note) -> bool:
	return notes.any(func(note): return note.name == new_note.name)

func _toggle_visibility() -> void:
	visible = !visible
	SoundManager.play_open_notebook()

func _on_notes_tab_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_show_notes()

func _on_inventory_tab_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_show_inventory()
		
func _show_notes() -> void:
	notes_tab.selected = true
	inventory_tab.selected = false
	notes_list.visible = true
	inventory_list.visible = false
	
func _show_inventory() -> void:
	inventory_tab.selected = true
	notes_tab.selected = false
	inventory_list.visible = true
	notes_list.visible = false

func _render_inventory_list() -> void:
	inventory_list.clear()
	for item in inventory:
		inventory_list.add_item(item.name, item.texture, item is Letter)
		
func _render_note_list() -> void:
	notes_list.clear()
	for note in notes:
		notes_list.add_item(note.name, null, true)

func _on_note_selected(index: int) -> void:
	note_display_text.text = notes[index].note
	note_display.show()

func _on_letter_selected(index: int) -> void:
	var letter = inventory[index] as Letter
	note_display_text.text = letter.letter
	note_display.show()
