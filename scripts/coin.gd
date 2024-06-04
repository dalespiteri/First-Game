extends Area2D

func _on_body_entered(body):
	print("got a coin!")
	queue_free()
