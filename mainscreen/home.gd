extends Control
var page
var room = preload("res://mainscreen/room.tscn")

func _ready() -> void:
	var _menu_option = $VBoxContainer/HBoxContainer2/Menu.get_popup().id_pressed.connect(_on_menu_id_pressed)
	$VBoxContainer/HBoxContainer2/TextureRect/HBoxContainer/Money2.text = str(PlayerprogressSavefile.money_2)
	$VBoxContainer/HBoxContainer2/TextureRect2/HBoxContainer/Money1.text = str(PlayerprogressSavefile.money_1)
func _on_menu_id_pressed(id: int):
	match id:
		0: 
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel.visible = true
			$VBoxContainer/screen.mouse_behavior_recursive = 2
		1: print("tutorial")
		2: 
			get_tree().change_scene_to_file("res://Start.tscn")
			
func _on_map_button_pressed() -> void:
	for step1_rand_furn in PlayerprogressSavefile.rooms[0]:
		# save format : [[[{ "furniture": "res://extra assets/Furnitures/furniture_3.tscn", "pos": (288.0, 1308.0), "cat_spawn": [0] }]],[]]
		for step2_rand_spot in step1_rand_furn[0]["cat_spawn"]:
			step1_rand_furn[0]["cat_spawn"] = [0]
	get_tree().change_scene_to_file("res://mainscreen/StagePicker.tscn")


func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscreen/shop.tscn")
	PlayerprogressSavefile.last_lobby = "res://mainscreen/Home.tscn"

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("touch"):
		print($ScrollContainer.scroll_horizontal)
		page = $ScrollContainer.scroll_horizontal
	if Input.is_action_just_released("touch"):
		var tween = create_tween()
		if $ScrollContainer.scroll_horizontal < page - 120:
			tween.tween_property($ScrollContainer, "scroll_horizontal", page - 1440 ,0.1)
		elif $ScrollContainer.scroll_horizontal > page + 120:
			tween.tween_property($ScrollContainer, "scroll_horizontal", page + 1440 ,0.1)
		else: tween.tween_property($ScrollContainer, "scroll_horizontal", page,0.1)
		#if page == 0:
			#if $ScrollContainer.scroll_horizontal >= 120:
				#tween.tween_property($ScrollContainer, "scroll_horizontal", 1444 ,0.1)
			#else: tween.tween_property($ScrollContainer, "scroll_horizontal", 0 ,0.1)
		#elif page == 1444:
			#if $ScrollContainer.scroll_horizontal <= 1444-120:
				#tween.tween_property($ScrollContainer, "scroll_horizontal", 0 ,0.1)
			#else: tween.tween_property($ScrollContainer, "scroll_horizontal", 1444 ,0.1)

func _on_button_pressed() -> void:
	$ScrollContainer/HBoxContainer.get_child(-2).add_sibling(room.instantiate())
	var current_scene = get_tree().current_scene
	var packed_scene = PackedScene.new()
	packed_scene.pack(current_scene)
	ResourceSaver.save(packed_scene, "res://Home.tscn")
	
func _on_close_pressed(which) -> void:
	match which:
		"settings":
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel.visible = false
			$VBoxContainer/screen.mouse_behavior_recursive = 1

func _on_sound_fx_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/ProgressBar.value = value

func _on_bgm_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/ProgressBar.value = value
