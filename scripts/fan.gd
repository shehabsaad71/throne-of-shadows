extends Area2D

var high = false
var play = false

func _physics_process(delta: float) -> void:
	if high:
		if get_parent().rotate:
			$"../player".position.y += 2
		else:
			$"../player".position.y -= 2
		$"../player".gravity = 0
		if !play:
			sound()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		high = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		high = false
		$"../player".gravity = 15
		$AudioStreamPlayer2D.stop()
		play = false

func sound():
	$AudioStreamPlayer2D.volume_db = global.value
	$AudioStreamPlayer2D.play()
	play = true
	await get_tree().create_timer(3).timeout
	$AudioStreamPlayer2D.stop()
	$AudioStreamPlayer2D.seek(0.0)
	play = false
