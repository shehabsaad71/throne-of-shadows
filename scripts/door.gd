extends Area2D

var new_level = ""
var menu = preload("res://scenes/main_menu.tscn").instantiate() as CanvasLayer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Sprite2D.visible = false
		$Sprite2D2.visible = true
		body.position.x = position.x
		body.can_input = false
		$AudioStreamPlayer2D.volume_db = global.value + 10
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		$AudioStreamPlayer2D.stop()
		body.door()
		await get_tree().create_timer(0.5).timeout
		$Sprite2D.visible = true
		$Sprite2D2.visible = false
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		global.levels += 1
		global.can_continue = true
		get_tree().change_scene_to_file("res://scenes/levels/level_"+new_level+".tscn")
