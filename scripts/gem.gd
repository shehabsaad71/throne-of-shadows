extends Area2D

func _physics_process(delta: float) -> void:
	if get_parent().respawn:
		$AnimatedSprite2D.visible = true
		$CollisionShape2D.shape = RectangleShape2D.new()
		$CollisionShape2D.shape.size = Vector2(51, 51)
		$AudioStreamPlayer2D.seek(0.0)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimatedSprite2D.visible = false
		$CollisionShape2D.shape = null
		body.coins += 5
		$AudioStreamPlayer2D.volume_db = global.value
		$AudioStreamPlayer2D.play()
