extends Control
var page
var room = preload("res://room.tscn")
func _on_map_button_pressed() -> void:
	get_tree().change_scene_to_file("res://StagePicker.tscn")

func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://shop.tscn")
	PlayerprogressSavefile.last_lobby = "res://Home.tscn"


func _on_scroll_container_scroll_started() -> void:
	print($ScrollContainer.scroll_horizontal)
	page = $ScrollContainer.scroll_horizontal

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("touch"):
		var tween = create_tween()
		#if page == 0:
			#if $ScrollContainer.scroll_horizontal >= 120:
				#tween.tween_property($ScrollContainer, "scroll_horizontal", 1444 ,0.1)
			#else: tween.tween_property($ScrollContainer, "scroll_horizontal", 0 ,0.1)
		#elif page == 1444:
			#if $ScrollContainer.scroll_horizontal <= 1444-120:
				#tween.tween_property($ScrollContainer, "scroll_horizontal", 0 ,0.1)
			#else: tween.tween_property($ScrollContainer, "scroll_horizontal", 1444 ,0.1)
		if $ScrollContainer.scroll_horizontal < page - 120:
			tween.tween_property($ScrollContainer, "scroll_horizontal", page - 1440 ,0.1)
		elif $ScrollContainer.scroll_horizontal > page + 120:
			tween.tween_property($ScrollContainer, "scroll_horizontal", page + 1440 ,0.1)
		else: tween.tween_property($ScrollContainer, "scroll_horizontal", page,0.1)

func _on_button_pressed() -> void:
	$ScrollContainer/HBoxContainer.get_child(-2).add_sibling(room.instantiate())
