class_name GameObject extends StaticBody2D

@export var dialogue: DialogueResource
@export var item: InventoryItem
@export var note: Note

func interact():
    if dialogue != null:
        DialogueManager.show_dialogue_balloon(dialogue)
        await DialogueManager.dialogue_ended
    if item != null:
        InventoryManager.add_inventory_item(item)
    elif note != null:
        InventoryManager.add_note(note)
    
    
