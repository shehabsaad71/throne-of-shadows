extends Node2D

var respawn = false

func _ready() -> void:
	$player.dead_high = 200
	$door.new_level = "6"
	global.save_progress()
