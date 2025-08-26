extends Area2D

var scroll = false
var speed = 4
var first_pos = Vector2(167, 210)

func _ready() -> void:
	if get_parent().scroll:
		scroll = true
		visible = true

func _physics_process(delta: float) -> void:
	if scroll:
		position.x += speed
	
	if get_parent().respawn:
		position = first_pos

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and scroll:
		body.live = 0
