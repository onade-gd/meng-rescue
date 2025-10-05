extends Control
@export var minimum_distance : float
@export var rarity : int
var stage = preload("res://resource/stage_resource.tres")
var score : int = 0 
var chosen_stage
var tween
func _ready() -> void:
	chosen_stage = stage.number[stage.which]
	$StageParent.get_child(0).free()
	$StageParent.add_child(chosen_stage.instantiate())
	
func _on_main_char_scoresignal(value) -> void:
	score += value
	$CanvasLayer/UI/VBoxContainer/MarginContainer/Score.text = str("score:", score)
	if score >= $StageParent/stage.get_meta("catsneeded"):
		$MoveForward/MainChar.winlose = 1
	
func _on_main_char_hp(value) -> void:
	if tween:
		tween.kill
	tween = create_tween()
	$CanvasLayer/UI/VBoxContainer/MarginContainer3/Health.text = str("health:",value)
	tween.tween_property($CanvasLayer/UI/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/TextureRect2/HBoxContainer/MarginContainer2,"custom_minimum_size:x",445.0*(value/3.0),0.3)

func _on_small_pressed() -> void:
	get_window().size = Vector2i(720, 1280)
