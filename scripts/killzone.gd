extends Area2D

@onready var death = $Death

func _on_body_entered(body):
	body.handle_hit(-1)
