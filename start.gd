extends Control

func _ready() -> void:
	#DirAccess.remove_absolute("user://file1.save")
	PlayerprogressSavefile.load_data()
func _on_texture_button_pressed() -> void:
	match PlayerprogressSavefile.first_times["first_login"]:
		true:
			get_tree().change_scene_to_file("res://story.tscn")
		false:
			get_tree().change_scene_to_file("res://mainscreen/StagePicker.tscn")
