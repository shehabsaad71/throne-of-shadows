extends Area2D

var spike = preload("res://scenes/spike.tscn")
var is_spike = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !is_spike:
		var new_spike = spike.instantiate()
		new_spike.position = Vector2(25, -200)
		new_spike.rotation = deg_to_rad(180)
		add_child(new_spike)
		fall(new_spike)
		new_spike = spike.instantiate()
		new_spike.position = Vector2(125, -200)
		new_spike.rotation = deg_to_rad(180)
		add_child(new_spike)
		fall(new_spike)
		new_spike = spike.instantiate()
		new_spike.position = Vector2(-75, -200)
		new_spike.rotation = deg_to_rad(180)
		add_child(new_spike)
		fall(new_spike)


func fall(spike: Area2D):
	is_spike = true
	for x in range(11):
		spike.position.y += 20
		await get_tree().create_timer(0.07).timeout
	spike.queue_free()
	is_spike = false
