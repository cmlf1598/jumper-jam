extends Area2D


func _on_body_entered(body):
	if body is Player:
		# jump if the player is falling down
		if body.velocity.y > 0:
			body.jump()
