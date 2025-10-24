extends Control
var stage_var = preload("res://resource/stage_resource.tres")
var page

func _ready() -> void:
	var menu_option = $VBoxContainer/HBoxContainer/Menu.get_popup().id_pressed.connect(_on_menu_id_pressed)
	$ScrollContainer2/HBoxContainer/ScrollContainer.scroll_vertical = 2864
func _on_button_pressed(extra_arg_0: int) -> void:
	stage_var.which = extra_arg_0
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer/TabContainer.current_tab = 0
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel.visible = true
	$VBoxContainer/screen.mouse_behavior_recursive = 2
	$focus.visible = true

func _on_menu_id_pressed(id: int):
	match id:
		0: 
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel.visible = true
			$VBoxContainer/screen.mouse_behavior_recursive = 2
			$focus.visible = true
		1: print("tutorial")
		2: 
			get_tree().change_scene_to_file("res://Start.tscn")

func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscreen/shop.tscn")
	PlayerprogressSavefile.last_lobby = "res://mainscreen/StagePicker.tscn"

func _input(_event: InputEvent) -> void:
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
	get_tree().change_scene_to_file("res://mainscreen/Home.tscn")

func _on_close_pressed(which) -> void:
	match which :
		"confirm":
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel.visible = false
			$VBoxContainer/screen.mouse_behavior_recursive = 1
			$focus.visible = false
		"settings":
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel.visible = false
			$VBoxContainer/screen.mouse_behavior_recursive = 1
			$focus.visible = false

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscreen/Main.tscn")

func _on_endless_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscreen/endless.tscn")

func _on_sound_fx_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/ProgressBar.value = value

func _on_bgm_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/ProgressBar.value = value
