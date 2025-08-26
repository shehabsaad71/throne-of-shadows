extends CharacterBody2D

var speed = 100
var first_pos = Vector2()
var fire = false
var play = false

func _ready() -> void:
	if get_parent().fire:
		fire = true
		$sprites.visible = true
	first_pos = position

func _physics_process(delta: float) -> void:
	if fire:
		velocity.y = -speed
		position.x = ($"../player".position.x)
		move_and_slide()
		$AudioStreamPlayer2D.volume_db = global.value
		$AudioStreamPlayer2D.play()
		if !play:
			play = true
			await get_tree().create_timer(1).timeout
			$AudioStreamPlayer2D.stop()
			$AudioStreamPlayer2D.seek(0.0)
			play = false
	if get_parent().respawn:
		position = first_pos

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and fire:
		body.live -= 1
