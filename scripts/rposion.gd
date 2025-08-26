extends Area2D

var text = 59

func _physics_process(delta: float) -> void:
	$CanvasLayer/Label.text = str(text)
	if get_parent().respawn:
		$Sprite2D.visible = true
		$CollisionShape2D.shape = RectangleShape2D.new()
		$CollisionShape2D.shape.size = Vector2(65, 65)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AudioStreamPlayer2D.volume_db = global.value
		$AudioStreamPlayer2D.play()
		$Sprite2D.visible = false
		$CollisionShape2D.shape = null
		get_parent().scale.y *= -1
		get_parent().rotate = true
		body.gravity = -body.gravity
		$CanvasLayer/Label.visible = true
		for i in range(59):
			await get_tree().create_timer(1).timeout
			text -= 1
		$CanvasLayer/Label.visible = false
		body.gravity = -body.gravity
		get_parent().scale.y *= -1
		get_parent().rotate = false
