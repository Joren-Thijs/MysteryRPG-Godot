extends CanvasLayer

@onready var notification_label: Label = $NotificationControl/MarginContainer/Panel/NotificationLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var notification_timer: Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    hide()
    InventoryManager.inventory_item_added.connect(display_inventory_notification)
    InventoryManager.note_added.connect(display_note_notification)
    setup_timer()

func setup_timer():
    add_child(notification_timer)
    notification_timer.one_shot = true
    notification_timer.wait_time = 4.0
    notification_timer.timeout.connect(on_notification_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func display_inventory_notification(item: InventoryItem) -> void:
    notification_label.text = "%s was added to your inventory" % item.notification_name
    animation_player.play("show_notification")
    SoundManager.play_item_added()
    notification_timer.start()
    
func display_note_notification(note: Note) -> void:
    notification_label.text = "You made a note about %s" % note.notification_name
    animation_player.play("show_notification")
    SoundManager.play_note_added()
    notification_timer.start()
    
func on_notification_timer_timeout() -> void:
    animation_player.play("hide_notification")
