extends Control
var stage_var = preload("res://resource/stage_resource.tres")
var page

func _on_button_pressed(extra_arg_0: int) -> void:
	stage_var.which = extra_arg_0
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://shop.tscn")

func _on_scroll_container_2_scroll_started() -> void:
	print($ScrollContainer2.scroll_horizontal)
	page = $ScrollContainer2.scroll_horizontal

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("touch"):
		var tween = create_tween()
		if page == 0:
			if $ScrollContainer2.scroll_horizontal >= 120:
				tween.tween_property($ScrollContainer2, "scroll_horizontal", 1452 ,0.1)
			else: tween.tween_property($ScrollContainer2, "scroll_horizontal", 0 ,0.1)
		elif page == 1452:
			if $ScrollContainer2.scroll_horizontal <= 1452-120:
				tween.tween_property($ScrollContainer2, "scroll_horizontal", 0 ,0.1)
			else: tween.tween_property($ScrollContainer2, "scroll_horizontal", 1452 ,0.1)

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Home.tscn")
