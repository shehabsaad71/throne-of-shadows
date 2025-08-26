extends Area2D

var can = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can:
		body.first_pos = position
		$AnimatedSprite2D.play("idle")
		$AudioStreamPlayer2D.volume_db = global.value
		$AudioStreamPlayer2D.play()
		can = false
