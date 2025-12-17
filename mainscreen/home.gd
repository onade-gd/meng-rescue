extends Control
var page
var room = preload("res://mainscreen/room.tscn")

func _ready() -> void:
	var _menu_option = $VBoxContainer/HBoxContainer2/Menu.get_popup().id_pressed.connect(_on_menu_id_pressed)
	for i in PlayerprogressSavefile.rooms:
		$ScrollContainer/HBoxContainer/Button.add_sibling(Control.new())
		$ScrollContainer/HBoxContainer.get_child(-1).set_custom_minimum_size(Vector2(1440,2560))
		$ScrollContainer/HBoxContainer.move_child($ScrollContainer/HBoxContainer.get_child(-1), -2)
		$ScrollContainer/HBoxContainer.get_child(-2).add_child(room.instantiate())
		$ScrollContainer/HBoxContainer.get_child(-2).get_child(0).set_mouse_filter(1)
		$ScrollContainer/HBoxContainer.get_child(-2).set_mouse_filter(1)
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
	get_tree().change_scene_to_file("res://mainscreen/StagePicker.tscn")
	for i in PlayerprogressSavefile.rooms.size():
		for x in PlayerprogressSavefile.rooms[i][0].size():
			for y in PlayerprogressSavefile.rooms[i][0][x][0]["cat_spawn"].size():
				PlayerprogressSavefile.rooms[i][0][x][0]["cat_spawn"][y] = 0
				
func _on_shop_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscreen/shop.tscn")
	PlayerprogressSavefile.last_lobby = "res://mainscreen/Home.tscn"
	for i in PlayerprogressSavefile.rooms.size():
		for x in PlayerprogressSavefile.rooms[i][0].size():
			for y in PlayerprogressSavefile.rooms[i][0][x][0]["cat_spawn"].size():
				PlayerprogressSavefile.rooms[i][0][x][0]["cat_spawn"][y] = 0
	
			#PlayerprogressSavefile.rooms[current_room][0][furniture_name][0]["furniture_id"]

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
	if PlayerprogressSavefile.money_2 < 200 :
		pass
	else:
		$ScrollContainer/HBoxContainer.get_child(-2).add_sibling(Control.new())
		$ScrollContainer/HBoxContainer.get_child(-2).set_custom_minimum_size(Vector2(1440,2560))
		$ScrollContainer/HBoxContainer.get_child(-2).set_mouse_filter(1)
		PlayerprogressSavefile.rooms.append([[],
		
		[ {
		0 : {
			"count": 0, 
			"image": "res://icon.svg",
			"cat_scene" : "res://extra assets/Furnitures/furniture_cat.tscn",
		},
		1 : {
			"count": 0, 
			"image": "res://icon.svg",
			"cat_scene" : "res://extra assets/Furnitures/furniture_cat.tscn",
		},
		2 : {
			"count": 0, 
			"image": "res://icon.svg",
			"cat_scene" : "res://extra assets/Furnitures/furniture_cat.tscn",
		},
		3 : {
			"count": 0, 
			"image": "res://icon.svg",
			"cat_scene" : "res://extra assets/Furnitures/furniture_cat.tscn",
		},
		4 : {
			"count": 0, 
			"image": "res://icon.svg",
			"cat_scene" : "res://extra assets/Furnitures/furniture_cat.tscn",
		},
		5 : {
			"count": 0, 
			"image": "res://icon.svg",
			"cat_scene" : "res://extra assets/Furnitures/furniture_cat.tscn",
		},
		6 : {
			"count": 0, 
			"image": "res://icon.svg",
			"cat_scene" : "res://extra assets/Furnitures/furniture_cat.tscn",
		},
		7 : {
			"count": 0,
			"image": "res://assets/Kepala/Tak berjudul324_20251212163445.png",
			"cat_scene" : "res://extra assets/cats/cat_7.tscn",
			}
		} ], 
		{"model": 0}
	])
		PlayerprogressSavefile.money_2 -= 200
		PlayerprogressSavefile.save_data()
		$VBoxContainer/HBoxContainer2/TextureRect/HBoxContainer/Money2.text = str(PlayerprogressSavefile.money_2)
		$ScrollContainer/HBoxContainer.get_child(-2).add_child(room.instantiate())
		$ScrollContainer/HBoxContainer.get_child(-2).get_child(0).set_mouse_filter(1)
	
func _on_close_pressed(which) -> void:
	match which:
		"settings":
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel.visible = false
			$VBoxContainer/screen.mouse_behavior_recursive = 1

func _on_sound_fx_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/ProgressBar.value = value

func _on_bgm_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/ProgressBar.value = value
