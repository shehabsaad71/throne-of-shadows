extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimationPlayer.play("zigzag")
		await get_tree().create_timer(0.7).timeout
		$StaticBody2D/Sprite2D.texture = null
		$StaticBody2D/CollisionShape2D.shape = null
		await get_tree().create_timer(1.5).timeout
		$StaticBody2D/Sprite2D.texture = preload("res://assets/fplatform.png")
		$StaticBody2D/CollisionShape2D.shape = RectangleShape2D.new()
		$StaticBody2D/CollisionShape2D.shape.size = Vector2(94, 55)


func _physics_process(delta: float) -> void:
	if get_parent().respawn:
		$AnimationPlayer.play("RESET")
		$StaticBody2D/Sprite2D.texture = preload("res://assets/fplatform.png")
		$StaticBody2D/CollisionShape2D.shape = RectangleShape2D.new()
		$StaticBody2D/CollisionShape2D.shape.size = Vector2(94, 55)
		get_parent().fplatform_respawn = false
