extends Area2D

var text = 59

func _physics_process(delta: float) -> void:
	$CanvasLayer/Label.text = str(text)
	if get_parent().respawn:
		$Sprite2D.visible = true
		$CollisionShape2D.shape = RectangleShape2D.new()
		$CollisionShape2D.shape.size = Vector2(35, 51)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Sprite2D.visible = false
		$CollisionShape2D.shape = null
		$AudioStreamPlayer2D.volume_db = global.value
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.1).timeout
		$AudioStreamPlayer2D.seek(0.0)
		if !get_parent().rotate:
			body.true_move = false
		else:
			body.true_move = true
		$CanvasLayer/Label.visible = true
		for i in range(59):
			await get_tree().create_timer(1).timeout
			text -= 1
		$CanvasLayer/Label.visible = false
		if !get_parent().rotate:
			body.true_move = true
		else:
			body.true_move = false

func rotate_camera():
	pass
