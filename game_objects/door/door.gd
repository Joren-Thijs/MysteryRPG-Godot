class_name Door extends GameObject

@export var required_key: InventoryItem

signal player_uses_door()

func interact():
    if required_key == null:
        SoundManager.play_open_door()
        player_uses_door.emit()
    else:
        if InventoryManager.inventory_has_item(required_key):
            player_uses_door.emit()
