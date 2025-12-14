extends Control
var page

func _ready() -> void:
	var read : int = 0
	for i in $ScrollContainer2/HBoxContainer/ScrollContainer/VBoxContainer/MarginContainer/Control.get_children():
		if PlayerprogressSavefile.stages[read]["first_clear"] == true:
			$ScrollContainer2/HBoxContainer/ScrollContainer/VBoxContainer/MarginContainer/Control.get_child(read+1).get_child(2).disabled = false
			$ScrollContainer2/HBoxContainer/ScrollContainer/VBoxContainer/MarginContainer/Control.get_child(read+1).modulate = Color.WHITE
			read += 1
		else: break
		
	var _menu_option = $VBoxContainer/HBoxContainer/Menu.get_popup().id_pressed.connect(_on_menu_id_pressed)
	$ScrollContainer2/HBoxContainer/ScrollContainer.scroll_vertical = 15000
	$VBoxContainer/HBoxContainer/TextureRect/HBoxContainer/Money2.text = str(PlayerprogressSavefile.money_2)
	$VBoxContainer/HBoxContainer/TextureRect2/HBoxContainer/Money1.text = str(PlayerprogressSavefile.money_1)
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/GridContainer/VBoxContainer/HBoxContainer/TextureRect/Label.text = str(PlayerprogressSavefile.booster_heart["count"])
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/GridContainer/VBoxContainer/HBoxContainer/TextureRect2/Label.text = str(PlayerprogressSavefile.booster_invincible["count"])
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/GridContainer/VBoxContainer/HBoxContainer/TextureRect3/Label.text = str(PlayerprogressSavefile.booster_magnet["count"])
func _on_button_pressed(extra_arg_0: int) -> void:
	StageResource.which = extra_arg_0
	var display_score = PlayerprogressSavefile.stages[StageResource.which]["stars"]
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel.visible = true
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer/StageDisplay.text = str("Stage " + str(extra_arg_0))
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/HBoxContainer/CatsNeeded.text = str(StageResource.number[StageResource.which]["cats"])
	match display_score :
		0.0 :
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star1.texture = preload("res://assets/0.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star2.texture = preload("res://assets/0.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star3.texture = preload("res://assets/0.png")
		1.0 :
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star1.texture = preload("res://assets/5.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star2.texture = preload("res://assets/0.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star3.texture = preload("res://assets/0.png")
		2.0 :
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star1.texture = preload("res://assets/5.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star2.texture = preload("res://assets/5.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star3.texture = preload("res://assets/0.png")
		3.0 :
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star1.texture = preload("res://assets/5.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star2.texture = preload("res://assets/5.png")
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/MarginContainer/star3.texture = preload("res://assets/5.png")
	$VBoxContainer/screen.mouse_behavior_recursive = 2
	$focus.visible = true

func _on_menu_id_pressed(id: int):
	match id:
		0: 
			$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel.visible = false
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
	for i in PlayerprogressSavefile.rooms.size():
		for x in PlayerprogressSavefile.rooms[i][0].size():
			for y in PlayerprogressSavefile.rooms[i][0][x][0]["cat_spawn"].size():
				PlayerprogressSavefile.rooms[i][0][x][0]["cat_spawn"][y] = 0
	get_tree().change_scene_to_file("res://mainscreen/Home.tscn")


func _on_close_pressed(which) -> void:
	print(PlayerprogressSavefile.rooms)
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
	get_tree().change_scene_to_file("res://load_room.tscn")
	
func _on_endless_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscreen/endless.tscn")

func _on_sound_fx_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/ProgressBar.value = value

func _on_bgm_value_changed(value: float) -> void:
	$VBoxContainer/screen/HBoxContainer/VBoxContainer/SettingsPanel/CenterContainer/VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/ProgressBar.value = value

func _on_heart_toggled(toggled_on: bool) -> void:
	if PlayerprogressSavefile.booster_heart["count"] > 0:
		StageResource.health = true
		print("pressed")
	else:
		$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/GridContainer/VBoxContainer/HBoxContainer/TextureRect/Heart.button_pressed = false

func _on_invincible_toggled(toggled_on: bool) -> void:
	if PlayerprogressSavefile.booster_invincible["count"] > 0:
		StageResource.invincible = true
	else:
		$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/GridContainer/VBoxContainer/HBoxContainer/TextureRect2/Invincible.button_pressed = false

func _on_magnet_toggled(toggled_on: bool) -> void:
	if PlayerprogressSavefile.booster_magnet["count"] > 0:
		StageResource.magnet = true
	else:
		$VBoxContainer/screen/HBoxContainer/VBoxContainer/ConfirmPanel/VBoxContainer/MarginContainer3/VBoxContainer/GridContainer/VBoxContainer/HBoxContainer/TextureRect3/Magnet.button_pressed = false
