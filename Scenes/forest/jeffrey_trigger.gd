extends Area2D

@onready var jeffrey: Jeffrey = %Jeffrey
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var triggered_before := false

func _on_body_entered(body: Node2D) -> void:
	var player := body as Player
	if not player || triggered_before:
		return
	
	jeffrey.set_navigation_target(body, jeffrey.talk)
	triggered_before = true
