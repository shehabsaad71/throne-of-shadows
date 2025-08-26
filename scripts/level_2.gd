extends Node2D

var respawn = false

func _ready() -> void:
	$player.dead_high = 200
	$door.new_level = "3"
	global.save_progress()
