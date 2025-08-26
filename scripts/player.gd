extends CharacterBody2D

var speed = 300
var gravity = 15
var jump = 400
var is_jumping = false
var dead_high = 0
var live = 1
var first_pos = Vector2()
var push = false
var coins = 0
var true_move = true
var walking_sound = preload("res://assets/sounds/walking.mp3")
var jumping_sound = preload("res://assets/sounds/jumping.mp3")
@onready var audio = $AudioStreamPlayer2D
var can_input = true
var is_pause = false

func _ready() -> void:
	if OS.get_name() != "Android":
		$CanvasLayer/TouchScreenButton.visible = false
		$CanvasLayer/TouchScreenButton2.visible = false
		$CanvasLayer/TouchScreenButton3.visible = false
		$CanvasLayer/Label2.text = (str(global.minutes)+" : 0"+str(global.seconds))
	if global.seconds < 10:
		$CanvasLayer/Label2.text = (str(global.minutes)+" : 0"+str(global.seconds))
	elif global.seconds < 60:
		$CanvasLayer/Label2.text = (str(global.minutes)+" : "+str(global.seconds))
	while true:
		await get_tree().create_timer(1).timeout
		global.seconds += 1
		if global.seconds < 10:
			$CanvasLayer/Label2.text = (str(global.minutes)+" : 0"+str(global.seconds))
		elif global.seconds < 60:
			$CanvasLayer/Label2.text = (str(global.minutes)+" : "+str(global.seconds))
		else:
			global.seconds = 0
			global.minutes += 1
			$CanvasLayer/Label2.text = (str(global.minutes)+" : 00")

func _physics_process(delta: float) -> void:
	velocity.y += gravity
	$AudioStreamPlayer2D.volume_db = global.value
	$AudioStreamPlayer2D2.volume_db = global.value
	if global.shadow:
		$DirectionalLight2D.shadow_enabled = true
	else:
		$DirectionalLight2D.shadow_enabled = false
	
	if global.speed_run:
		$CanvasLayer/Label2.visible = true
	else:
		$CanvasLayer/Label2.visible = false
	
	if global.sq == 1:
		$DirectionalLight2D.shadow_filter = Light2D.SHADOW_FILTER_NONE
		$DirectionalLight2D.shadow_filter_smooth = 0.0
	elif global.sq == 2:
		$DirectionalLight2D.shadow_filter = Light2D.SHADOW_FILTER_PCF5
		$DirectionalLight2D.shadow_filter_smooth = 2.0
	elif global.sq == 3:
		$DirectionalLight2D.shadow_filter = Light2D.SHADOW_FILTER_PCF13
		$DirectionalLight2D.shadow_filter_smooth = 3.0
	elif global.sq == 4:
		$DirectionalLight2D.shadow_filter = Light2D.SHADOW_FILTER_PCF13
		$DirectionalLight2D.shadow_filter_smooth = 5.0
	
	if is_on_floor():
		is_jumping = false
	
	if push:
		velocity.x -= 50
	
	$CanvasLayer/Label.text = str(coins)
	
	if Input.is_action_pressed("right") and can_input:
		if true_move:
			right_move()
		else:
			left_move()
		if Input.is_action_just_pressed("right") and is_on_floor():
			audio.stop()
			audio.stream = walking_sound
			audio.play()
	elif Input.is_action_pressed("left") and can_input:
		if true_move:
			left_move()
		else:
			right_move()
		if Input.is_action_just_pressed("left") and is_on_floor():
			audio.stop()
			audio.stream = walking_sound
			audio.play()
	else:
		if !is_jumping:
			$AnimatedSprite2D.play("IDLE")
			audio.stop()
		if !push:
			velocity.x = 0
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_input:
		velocity.y = -jump
		$AnimatedSprite2D.play("jump")
		is_jumping = true
		audio.seek(0.0)
		audio.stop()
		audio.stream = jumping_sound
		audio.play()
	
	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	if position.y > dead_high or live == 0:
		dead()
		await get_tree().create_timer(0.5).timeout
		position = first_pos
		live = 1
		coins = 0
		get_parent().respawn = true
		await get_tree().create_timer(0.00000001).timeout
		get_parent().respawn = false
	
	move_and_slide()

func right_move():
	velocity.x = speed
	$AnimatedSprite2D.flip_h = false
	if !is_jumping:
		$AnimatedSprite2D.play("run")

func left_move():
	velocity.x = -speed
	$AnimatedSprite2D.flip_h = true
	if !is_jumping:
		$AnimatedSprite2D.play("run")

func dead():
	can_input = false
	$AudioStreamPlayer2D2.play()
	$CanvasLayer/dead.visible = true
	$CanvasLayer/dead2.visible = true
	$AnimationPlayer.play("dead")
	await get_tree().create_timer(0.8).timeout
	$AnimationPlayer.play_backwards("dead")
	await get_tree().create_timer(0.5).timeout
	$CanvasLayer/dead.visible = false
	$CanvasLayer/dead2.visible = false
	can_input = true

func door():
	$AnimationPlayer.play("door")
