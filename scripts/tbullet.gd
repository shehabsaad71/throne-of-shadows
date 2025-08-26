extends Area2D

var speed = 500  # سرعة الرصاصة
var direction = 1  # 1 يمين، -1 شمال
var boom = false
var pos = position

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	queue_free()

func _physics_process(delta):
	position.x += speed * direction * delta
	# امسح الرصاصة لو طلعت برا حدود الشاشة أو ضربت العدو (لو boom == true)
	#if position.x > 2000 or position.x < -2000:
	#	queue_free()

func _on_body_entered(body):
	if !body.is_in_group("turret"):
		queue_free()
	if body.is_in_group("player"):
		body.live -= 1
		boom = true


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if !area.is_in_group("turret"):
		queue_free()
