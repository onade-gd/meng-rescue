extends Control
var stage_var = preload("res://resource/stage_resource.tres")

func _on_button_pressed(extra_arg_0: int) -> void:
	stage_var.which = extra_arg_0
	get_tree().change_scene_to_file("res://Main.tscn")
