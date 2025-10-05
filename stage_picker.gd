extends Control
var stage_var = preload("res://resource/stage_resource.tres")
var page

func _ready() -> void:
	$ScrollContainer2/HBoxContainer/ScrollContainer.scroll_vertical = 2864
func _on_button_pressed(extra_arg_0: int) -> void:
	stage_var.which = extra_arg_0
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://shop.tscn")
	PlayerprogressSavefile.last_lobby = "res://StagePicker.tscn"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("touch"):
		page = $ScrollContainer2.scroll_horizontal
		print($ScrollContainer2.scroll_horizontal)
	if Input.is_action_just_released("touch"):
		var tween = create_tween()
		if $ScrollContainer2.scroll_horizontal < page - 120:
			tween.tween_property($ScrollContainer2, "scroll_horizontal", page - 1440 ,0.1)
		elif $ScrollContainer2.scroll_horizontal > page + 120:
			tween.tween_property($ScrollContainer2, "scroll_horizontal", page + 1440 ,0.1)
		else: tween.tween_property($ScrollContainer2, "scroll_horizontal", page,0.1)
		#if page == 0:
			#if $ScrollContainer2.scroll_horizontal >= 120:
				#tween.tween_property($ScrollContainer2, "scroll_horizontal", 1440 ,0.1)
			#else: tween.tween_property($ScrollContainer2, "scroll_horizontal", 0 ,0.1)
		#elif page == 1440:
			#if $ScrollContainer2.scroll_horizontal <= 1440-120:
				#tween.tween_property($ScrollContainer2, "scroll_horizontal", 0 ,0.1)
			#else: tween.tween_property($ScrollContainer2, "scroll_horizontal", 1440 ,0.1)

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Home.tscn")
