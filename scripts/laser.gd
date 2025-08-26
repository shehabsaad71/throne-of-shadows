extends Node2D

var speed = 2.5
var play = false
@onready var pos_1 = $laser.position
@onready var pos_2 = $laser2.position

func _ready() -> void:
	if get_parent().laser:
		visible = true

func _physics_process(delta: float) -> void:
	$laser.position.x = $"../player".position.x
	$laser2.position.x = $"../player".position.x
	if get_parent().respawn:
		$laser.position.y = pos_1.y
		$laser2.position.y = pos_2.y
	
	if get_parent().laser:
		$laser.velocity.y = -2.5
		$laser.move_and_slide()
		$laser2.velocity.y = 2.5
		$laser2.move_and_slide()
		if !play:
			$AudioStreamPlayer2D.volume_db = global.value + 10
			$AudioStreamPlayer2D.play()
			play = true
			await get_tree().create_timer(3).timeout
			$AudioStreamPlayer2D.stop()
			$AudioStreamPlayer2D.seek(0.0)
			play = false

func _on_laser_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and get_parent().laser:
		body.live -= 1
