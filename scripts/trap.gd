extends Area2D

var kill = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.play("push")
		await get_tree().create_timer(0.1).timeout
		if kill:
			body.live -= 1


func _on_killzone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		kill = true

func _on_killzone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		kill = false
