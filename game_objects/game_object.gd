class_name GameObject extends StaticBody2D

@export var item: InventoryItem
@export var note: Note
@export var dialogue: DialogueResource

func interact():
    if item != null:
        InventoryManager.add_inventory_item(item)
    elif note != null:
        InventoryManager.add_note(note)
    elif dialogue != null:
        DialogueManager.show_dialogue_balloon(dialogue)
    
