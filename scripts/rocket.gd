extends CharacterBody2D

func _physics_process(delta: float) -> void:
	velocity.x = -400
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.live -= 1
