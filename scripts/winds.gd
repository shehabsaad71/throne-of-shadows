extends Area2D

var wind = false
var play = false

func _process(delta: float) -> void:
	if wind and !play:
		play = true
		$AudioStreamPlayer2D.volume_db = global.value
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(3).timeout
		$AudioStreamPlayer2D.stop()
		$AudioStreamPlayer2D.seek(0.0)
		play = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.push = true
		body.speed = 100
		wind = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.push = false
		body.speed = 300
		wind = false
		if play:
			$AudioStreamPlayer2D.stop()
			$AudioStreamPlayer2D.seek(0.0)
			play = false
