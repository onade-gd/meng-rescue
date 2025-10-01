extends Control

func _on_map_button_pressed() -> void:
	get_tree().change_scene_to_file("res://StagePicker.tscn")

func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://shop.tscn")
