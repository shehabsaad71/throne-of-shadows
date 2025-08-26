extends StaticBody2D

var dir = 1
var bullet = preload("res://scenes/tbullet.tscn")
var shoot = false

func _ready() -> void:
	await get_tree().create_timer(0.00001).timeout
	if dir == 1:
		$AnimatedSprite2D.flip_h = false
	elif dir == -1:
		$AnimatedSprite2D.flip_h = true
	
	await get_tree().create_timer(1).timeout
	while true:
		if shoot:
			$AnimatedSprite2D.play("shoot")
			await get_tree().create_timer(0.6).timeout
			$AudioStreamPlayer2D.volume_db = global.value
			$AudioStreamPlayer2D.play()
			await get_tree().create_timer(0.4).timeout
			var new_bullet = bullet.instantiate()
			new_bullet.position = Vector2(position.x + 40, position.y)  # أو مكان إطلاق مناسب بالنسبة للاعب
			new_bullet.direction = dir
			get_parent().add_child(new_bullet)
			await get_tree().create_timer(1).timeout
		else:
			await get_tree().create_timer(0.1).timeout 

func _physics_process(delta: float) -> void:
	if $"../player".position.x > position.x -500 and $"../player".position.x < position.x + 500:
		if $"../player".position.y > position.y - 266 and $"../player".position.y < position.y + 266:
			shoot = true
		else:
			shoot = false
	else:
		shoot = false
