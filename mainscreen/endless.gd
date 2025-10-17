extends Control
@export var minimum_distance : float
@export var rarity : int
var stage = preload("res://resource/stage_resource.tres")
var score : int = 0 
var chosen_stage
var tween
var next_stage
var spawn = 0
func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if $StageParent.get_child_count() < 3:
		chosen_stage = $StageParent.get_child(-1).get_meta("next").pick_random()
		spawn = spawn + $StageParent.get_child(-1).get_meta("end")
		next_stage = chosen_stage.instantiate()
		$StageParent.add_child(next_stage)
		next_stage.position = Vector2(0,spawn)

func _on_main_char_hp(value) -> void:
	if tween:
		tween.kill
	tween = create_tween()
	$CanvasLayer/UI/VBoxContainer/MarginContainer3/Health.text = str("health:",value)
	tween.tween_property($CanvasLayer/UI/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/TextureRect2/HBoxContainer/MarginContainer2,"custom_minimum_size:x",445.0*(value/3.0),0.3)

func _on_main_char_scoresignal(value) -> void:
	score += value
	$CanvasLayer/UI/VBoxContainer/MarginContainer/Score.text = str("score:", score)
	if score >= $StageParent/stage.get_meta("catsneeded"):
		$MoveForward/MainChar.winlose = 1
