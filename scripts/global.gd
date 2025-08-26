# Global.gd
extends Node

# بيانات اللاعب
var levels: int = 0
var can_continue: bool = false
var value = 0
var fs = false
var v_sync = true
var shadow = true
var story = true
var sq = 2
var seconds = 0
var minutes = 0
var speed_run = false

# دالة حفظ التقدم
func save_progress():
	var save_file = FileAccess.open("user://save_game.save", FileAccess.ModeFlags.WRITE)
	var data = {
		"levels": levels,
		"can_continue": can_continue,
		"value": value,
		"fs": fs,
		"v_sync": v_sync,
		"shadow": shadow,
		"story": story
	}
	save_file.store_string(JSON.stringify(data))
	save_file.close()

# دالة تحميل التقدم
func load_progress():
	if FileAccess.file_exists("user://save_game.save"):
		var save_file = FileAccess.open("user://save_game.save", FileAccess.ModeFlags.READ)
		var text = save_file.get_as_text()
		save_file.close()
		
		# تحويل JSON لنص إلى Dictionary
		var data = JSON.parse_string(text)  # هنا data هي Dictionary مباشرة
		
		if typeof(data) == TYPE_DICTIONARY:
			levels = data.get("levels", 0)
			can_continue = data.get("can_continue", false)
			value = data.get("value", 0)
			fs = data.get("fs", false)
			v_sync = data.get("v_sync", true)
			story = data.get("story", true)
			shadow = data.get("shadow", true)
		else:
			# لو فيه خطأ، نرجع القيم الافتراضية
			levels = 0
			can_continue = false
			value = 0
			fs = false
			v_sync = true
			shadow = true
			story = true


# تستدعي التحميل عند بدء اللعبة
func _ready():
	load_progress()
