extends Area2D

var enter = false

func _physics_process(delta: float) -> void:
	if get_parent().respawn:  # تأكد إنه مش فاضي
		$AnimationPlayer.play("RESET")
		$StaticBody2D3.visible = false
		enter = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !enter:
		$AnimationPlayer.play("fall")
		$AudioStreamPlayer2D.volume_db = global.value
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		$StaticBody2D3.visible = true
		enter = true
		$AudioStreamPlayer2D.stop()
		$AudioStreamPlayer2D.seek(0.0)
