class_name Door extends GameObject

signal player_uses_door()

func interact():
    player_uses_door.emit()
