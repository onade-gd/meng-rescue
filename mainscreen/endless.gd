extends Control
@export var minimum_distance : float
@export var rarity : int
var stage = preload("res://resource/stage_resource.tres")
var score : int = 0 
var chosen_stage : Array = [
	load("res://stages endless/0.tscn"),
	load("res://stages endless/1.tscn"),
	load("res://stages endless/2.tscn"),
	load("res://stages endless/3.tscn"),
	load("res://stages endless/4.tscn"),
	load("res://stages endless/5.tscn"),
	load("res://stages endless/6.tscn"),
	load("res://stages endless/7.tscn"),
	load("res://stages endless/8.tscn"),
	load("res://stages endless/9.tscn")
]
var tween
var next_stage
var spawn = 0
func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	print($StageParent.get_child(-1))
	if $StageParent.get_child_count() < 3:
		next_stage = chosen_stage[$StageParent.get_child(-1).get_meta("next").pick_random()].instantiate()
		spawn = spawn - 2400
		$StageParent.add_child(next_stage)
		next_stage.position = Vector2(0,spawn)
	if $StageParent.get_child(-1).global_position.y == -4960:
		$StageParent.get_child(-1).queue_free()
		
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
