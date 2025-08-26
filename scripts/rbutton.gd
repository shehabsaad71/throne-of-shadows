extends Area2D

@onready var sprite := $StaticBody2D/Sprite2D
var bullet = preload("res://scenes/rocket.tscn")
var press = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !press:
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.1).timeout
		var rect = sprite.region_rect
		rect.position.x = 157
		rect.size.x = 102
		rect.size.y = 72
		sprite.region_rect = rect

		await get_tree().create_timer(0.1).timeout
		rect = sprite.region_rect
		rect.position.x = 283
		rect.size.x = 104
		rect.size.y = 74.5
		$CollisionShape2D.shape.size.y = 40
		sprite.region_rect = rect
		shoot()
		press = true
		await get_tree().create_timer(1).timeout
		press = false
		rect.position.x = 32
		rect.size.x = 100
		rect.size.y = 72
		$CollisionShape2D.shape.size.y = 52
		sprite.region_rect = rect

func shoot():
	var new_rocket = bullet.instantiate()
	new_rocket.position = Vector2(position.x + 100, position.y - 71)
	add_child(new_rocket)
	await get_tree().create_timer(2).timeout
	new_rocket.queue_free()
