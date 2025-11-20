extends Control
@export var minimum_distance : float
@export var rarity : int
var score : int = 0 
var chosen_stage
var tween
var max_health = 3
func _ready() -> void:
	$CanvasLayer/winlosescreen/star1.visible = false
	$CanvasLayer/winlosescreen/star2.visible = false
	$CanvasLayer/winlosescreen/star3.visible = false
	chosen_stage = load(str(StageResource.number[StageResource.which]["path"]))
	if StageResource.health == true :
		_health()
	if StageResource.invincible == true :
		$MoveForward/MainChar.invincible = true
		$MoveForward/MainChar.invc_available = true
	$StageParent.add_child(chosen_stage.instantiate())
	
func _on_main_char_scoresignal(value) -> void:
	score += value
	print(score)
	$CanvasLayer/UI/VBoxContainer/MarginContainer/Score.text = str("score:", score)
	if score >= $StageParent/stage.get_meta("catsneeded"):
		$MoveForward/MainChar.winlose = 1
		#PlayerprogressSavefile.ownership_cats["cat_1"] = {
		#"inventory" : true,
		#"room" : null,
		#}
func _on_main_char_hp(value) -> void:
	if tween:
		tween.kill
	tween = create_tween()
	$CanvasLayer/UI/VBoxContainer/MarginContainer3/Health.text = str("health:",value)
	tween.tween_property($CanvasLayer/UI/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/TextureRect2/HBoxContainer/MarginContainer2,"custom_minimum_size:x",445.0*(value/float(max_health)),0.3)

func _on_main_char_finishline(endcondition) -> void:
	var final_score = floor((float(score)/float($StageParent/stage.get_meta("catsneeded")))*3)
	if final_score > 3.0: final_score = 3.0
	if endcondition == "death":
			final_score = 0.0
	else:
		if PlayerprogressSavefile.stages[StageResource.which]["stars"] < final_score:
			PlayerprogressSavefile.stages[StageResource.which]["stars"] = final_score
	match final_score :
		0.0: 
			$CanvasLayer/winlosescreen/Win.visible = false
			$CanvasLayer/winlosescreen/Lose.visible = true
		1.0: $CanvasLayer/winlosescreen/star1.texture = preload("res://assets/5.png")
		2.0: 
			$CanvasLayer/winlosescreen/star1.texture = preload("res://assets/5.png")
			$CanvasLayer/winlosescreen/star2.texture = preload("res://assets/5.png")
		3.0:
			$CanvasLayer/winlosescreen/star1.texture = preload("res://assets/5.png")
			$CanvasLayer/winlosescreen/star2.texture = preload("res://assets/5.png")
			$CanvasLayer/winlosescreen/star3.texture = preload("res://assets/5.png")
	await $MoveForward/MainChar/AnimationPlayer.animation_finished
	$CanvasLayer/winlosescreen.visible = true
	$CanvasLayer/winlosescreen/Win.play("default")
	$CanvasLayer/winlosescreen/Lose.play("default")
	await $CanvasLayer/winlosescreen/Win.animation_finished
	$CanvasLayer/winlosescreen/AnimationPlayer.play("stars_popout")

func _on_exit_pressed() -> void:
	print("pressed")
	PlayerprogressSavefile.save_data()
	StageResource.invincible = false
	StageResource.health = false
	StageResource.magnet = false
	queue_free()
	get_tree().change_scene_to_file("res://mainscreen/StagePicker.tscn")

func _on_repeat_pressed() -> void:
	get_tree().change_scene_to_file("res://load_room.tscn")

func _health():
	max_health = 6
	$MoveForward/MainChar.health = max_health
	
