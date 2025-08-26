extends Area2D

var spring = -800

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"StaticBody2D/AnimatedSprite2D".play("spring")
		await get_tree().create_timer(0.1333).timeout
		body.velocity.y = spring


func _physics_process(delta: float) -> void:
	if $"../Player".gravity_side == 1:
		spring = -800
	elif  $"../Player".gravity_side == 0:
		spring = 800
