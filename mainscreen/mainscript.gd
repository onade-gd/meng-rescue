extends Control
@export var minimum_distance : float
@export var rarity : int
var stage = preload("res://resource/stage_resource.tres")
var score : int = 0 
var chosen_stage
var tween
func _ready() -> void:
	$CanvasLayer/winlosescreen/star1.visible = false
	$CanvasLayer/winlosescreen/star2.visible = false
	$CanvasLayer/winlosescreen/star3.visible = false
	chosen_stage = stage.number[stage.which]
	$StageParent.get_child(0).free()
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
	tween.tween_property($CanvasLayer/UI/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/TextureRect2/HBoxContainer/MarginContainer2,"custom_minimum_size:x",445.0*(value/3.0),0.3)

func _on_main_char_finishline() -> void:
	var final_score = floor((float(score)/float($StageParent/stage.get_meta("catsneeded")))*3)
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
	get_tree().change_scene_to_file("res://mainscreen/StagePicker.tscn")
