extends CanvasLayer

var toast = false
var menu = true
var story = true

func _ready() -> void:
	animate()
	$options/HSlider.max_value = 24
	$options/HSlider.min_value = -80
	$options/HSlider.value = global.value
	if !global.v_sync:
		$options/CheckButton2.button_pressed = false
	if global.fs:
		$options/CheckBox.button_pressed = true
	if !global.shadow:
		$options/CheckButton3.button_pressed = false
	if !global.story:
		$options/CheckButton.button_pressed = false
	if global.fs:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		scale = Vector2(1.2, 1.2)
	if OS.get_name() == "Android":
		$options/CheckBox.disabled = true
	if global.can_continue:
		$menu/TouchScreenButton5.texture_normal = preload("res://assets/continue.png")

func animate():
	while true:
		await get_tree().create_timer(1).timeout
		$menu/AnimatedSprite2D.play("jump")
		$menu/AnimationPlayer.play("jump")
		$menu/AnimatedSprite2D2.play("shoot")
		$menu/AnimationPlayer2.play("shoot")
		if menu:
			$menu/AudioStreamPlayer2D.volume_db = global.value
			$menu/AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		$menu/AnimationPlayer.play_backwards("jump")
		await get_tree().create_timer(0.5).timeout
		$menu/AnimatedSprite2D.play("IDLE")
		$menu/AudioStreamPlayer2D.stop()
		$menu/AudioStreamPlayer2D.seek(0.0)

func _physics_process(delta: float) -> void:
	$menu/AudioStreamPlayer2D2.volume_db = global.value

func _on_touch_screen_button_4_pressed() -> void:
	get_tree().quit()


func _on_touch_screen_button_5_pressed() -> void:
	if global.can_continue:
		get_tree().change_scene_to_file("res://scenes/levels/level_"+ str(global.levels + 1) +".tscn")
	else:
		$menu/AudioStreamPlayer2D2.stream = preload("res://assets/sounds/beep.mp3")
		$menu/AudioStreamPlayer2D2.play()
		await get_tree().create_timer(1).timeout
		$menu/AudioStreamPlayer2D2.stream = preload("res://assets/sounds/click.mp3")
		if !toast:
			$"menu/AnimationPlayer3".play("toast")
			toast = true
			await get_tree().create_timer(3).timeout
			$"menu/AnimationPlayer3".play_backwards("toast")
			toast = false

func _on_touch_screen_button_pressed() -> void:
	var text = ""
	if story:
		text = "story"
	else:
		text = "levels/level_1"
	$menu/AudioStreamPlayer2D2.play()
	get_tree().change_scene_to_file("res://scenes/"+ text +".tscn")
	global.can_continue = false
	global.levels = 0
	global.save_progress()


func _on_credits_touch_screen_button_pressed() -> void:
	OS.shell_open("https://shehabs.netlify.app")
	$menu/AudioStreamPlayer2D2.play()


func _on_label_2_mouse_entered() -> void:
	$credits/Label2.add_theme_color_override("font_color", Color.html("#0094b3"))
	$menu/AudioStreamPlayer2D2.play()

func _on_label_2_mouse_exited() -> void:
	$credits/Label2.add_theme_color_override("font_color", Color.html("#24d5ff"))
	$menu/AudioStreamPlayer2D2.play()

func _on_touch_screen_button_3_pressed() -> void:
	$AnimationPlayer.play("credits")
	menu = false
	$menu/AudioStreamPlayer2D2.play()


func _on_touch_screen_button_2_pressed() -> void:
	$AnimationPlayer.play("credits-back")
	menu = true
	$menu/AudioStreamPlayer2D2.play()


func _on_check_box_toggled(pressed: bool) -> void:
	if pressed:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		scale = Vector2(1.2, 1.2)
		global.fs = true
	else:
		DisplayServer.window_set_size(Vector2i(1152, 648))
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#scale = Vector2(1, 1)
		global.fs = false
	$menu/AudioStreamPlayer2D2.play()
	global.save_progress()


func _on_h_slider_value_changed(value: int) -> void:
	global.value = value
	global.save_progress()


func _on_check_button_pressed() -> void:
	story = !story
	global.save_progress()
	$menu/AudioStreamPlayer2D2.play()


func _on_check_button_2_pressed() -> void:
	if !global.v_sync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		global.v_sync = true
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		global.v_sync = false
	$menu/AudioStreamPlayer2D2.play()
	global.save_progress()


func _on_check_button_3_pressed() -> void:
	global.shadow = !global.shadow
	$options/SpinBox.editable = !$options/SpinBox.editable
	global.save_progress()
	$menu/AudioStreamPlayer2D2.play()


func _on_spin_box_value_changed(value: int) -> void:
	match value:
		1:
			$options/SpinBox.suffix = "Low"
			global.sq = 1
		2:
			$options/SpinBox.suffix = "Med"
			global.sq = 2
		3:
			$options/SpinBox.suffix = "High"
			global.sq = 3
		4:
			$options/SpinBox.suffix = "Ultra"
			global.sq = 4
	$menu/AudioStreamPlayer2D2.play()
	global.save_progress()


func _on_check_button_4_pressed() -> void:
	global.speed_run = !global.speed_run
	$menu/AudioStreamPlayer2D2.play()


func _on_options_back_touch_screen_button_pressed() -> void:
	$AnimationPlayer.play_backwards("options")
	menu = true
	$menu/AudioStreamPlayer2D2.play()


func _on_options_go_touch_screen_button_2_pressed() -> void:
	$AnimationPlayer.play("options")
	menu = false
	$menu/AudioStreamPlayer2D2.play()
