extends Node2D

var write = true
var text = "\n\nKing Aldramen has lived his entire life haunted by the specter of betrayal."
var can_skip = false
var scene = 0

func _ready() -> void:
	type_text($Label, text)
	$AudioStreamPlayer2D.stream.loop = true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("skip") and can_skip:
		if scene == 0:
			skip("\nTwenty years ago, a rebellion of the nobles occurred: the leading families \ntried to depose him in order to impose a king from their lineage.", "res://assets/Copilot_20250822_195727.png")
			type_text($Label, text)
		elif scene == 1:
			skip("\nOn a bloody night  his only son died defending the palace\nand from that time Aldramon does not have a heir.", "res://assets/Copilot_20250822_195658.png")
			type_text($Label, text)
		elif scene == 2:
			skip("\nThis incident transformed him from a warrior king to a wise king\nbut he was always worried about his kingdom if he died.", "res://assets/Copilot_20250822_200524.png")
			type_text($Label, text)
		elif scene == 3:
			skip("\nThe nobles have not forgotten their ambition, and everyone is waiting for the\nmoment of the king's death so that they can divide the kingdom as spoils.", "res://assets/Copilot_20250822_200834.png")
			type_text($Label, text)
		elif scene == 4:
			skip('\nFor this reason, he announced the "Great Competition": the throne bid. He announced it not to play,\nbut because he wanted to prove to the world that the throne was not and will\nnot be reserved for the blue-blooded, but for those who truly deserve it.', "res://assets/Copilot_20250822_201136.png")
			type_text($Label2, text)
		elif scene == 5:
			skip("\nOur hero: Hugo,\na poor young man from a small fishing village on the outskirts of Orfelice.", "res://assets/Copilot_20250822_201758.png")
			type_text($Label, text)
		elif scene == 6:
			$Label.position.x = 2.5
			skip("\nHis father was a simple fisherman, who was unjustly killed in the rebellion,\nnot as a rebel but as one of the peasants who accused them of helping the king.", "res://assets/Copilot_20250822_202257.png")
			type_text($Label, text)
		elif scene == 7:
			$Label.position.x = 17
			skip("\nHis mother died of hunger and cold when taxes were increased on the villages.", "res://assets/Copilot_20250823_010347.png")
			type_text($Label, text)
		elif scene == 8:
			$Label.position.x = 27
			skip("\nSince then, Hugo has lived by fishing for a living\nor selling simple items in the market, ostracized by everyone.", "res://assets/Copilot_20250823_010604.png")
			type_text($Label, text)
		elif scene == 9:
			skip("\nThere is a great anger inside him.\nNot just hunger, but a feeling that there is no justice in the world.", "res://assets/Copilot_20250823_010604.png")
			type_text($Label, text)
		elif scene == 10:
			$Label.position.x = 2.5
			skip('When he heard about the "Great Competition," he did not think about the throne\nbut rather, he thought that it was his last resort: either he would die,\nor he would find a reason to live.', "res://assets/Copilot_20250823_011334.png")
			type_text($Label, text)
		elif scene == 11:
			get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func type_text(label: Label, text: String) -> void:
	label.text = ""
	can_skip = false
	$AudioStreamPlayer2D.play()
	for i in text.length():
		if not write:
			break
		label.text += text[i]
		await get_tree().create_timer(0.05).timeout
	can_skip = true
	$AudioStreamPlayer2D.stop()
	$AudioStreamPlayer2D.seek(0.0)
	$AnimationPlayer.stop()

func skip(new_text, new_image):
	$Label.text = ""
	$Label2.text = ""
	text = new_text
	$AnimationPlayer.play("RESET")
	$Sprite2D.texture = load(new_image)
	$AnimationPlayer.play("idle")
	scene += 1
