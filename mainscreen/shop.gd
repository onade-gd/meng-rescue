extends Control

func _ready() -> void:
	$VBoxContainer/MarginContainer/HBoxContainer2/TextureRect/HBoxContainer/Money2.text = str(PlayerprogressSavefile.money_2)
	$VBoxContainer/MarginContainer/HBoxContainer2/TextureRect2/HBoxContainer/Money1.text = str(PlayerprogressSavefile.money_1)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(PlayerprogressSavefile.last_lobby)
