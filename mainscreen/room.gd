extends Control
var new_placement
var tween
var furniture_name
var furniture_index
var confirmable: bool
var cat = 3
var new_or_edit : String
func _ready() -> void:
	var total_furn_spot : int = 0
	var availability : Array
	availability.resize($AltSpawns.get_child_count())
	for i in range(availability.size()):
		availability[i] = 0
	for furnitures in PlayerprogressSavefile.rooms[0]:
		$FurnitureContainer.add_child(load(furnitures[0]["furniture"]).instantiate())
		$FurnitureContainer.get_child(-1).position = Vector2(furnitures[0]["pos"])
	for i in $FurnitureContainer.get_child_count():
		total_furn_spot += $FurnitureContainer.get_child(i).find_child("Sleep").get_child_count()
	print("total furn spot:" ,total_furn_spot)
	while cat > 0:
		if total_furn_spot > 0:
			var step1_rand_furn = randi_range(0, $FurnitureContainer.get_child_count()-1)
			var step2_rand_spot = randi_range(0,$FurnitureContainer.get_child(step1_rand_furn).find_child("Sleep").get_child_count()-1)
			if PlayerprogressSavefile.rooms[0][step1_rand_furn][0]["cat_spawn"][step2_rand_spot] == 0:
				$FurnitureContainer.get_child(step1_rand_furn).get_child(2).get_child(step2_rand_spot).add_child(preload("res://extra assets/Furnitures/furniture_cat.tscn").instantiate())
				PlayerprogressSavefile.rooms[0][step1_rand_furn][0]["cat_spawn"][step2_rand_spot] = 1
				cat -= 1
				total_furn_spot -= 1
				print("total furn spot:",total_furn_spot , "  cats left:",cat)
				print(step1_rand_furn, " ",step2_rand_spot)
			else:
				pass
		else: 
			var rand_spot = randi_range(0,$AltSpawns.get_child_count()-1)
			if availability[rand_spot] == 0:
				$AltSpawns.get_child(rand_spot).add_child(preload("res://extra assets/Furnitures/furniture_cat.tscn").instantiate())
				availability[rand_spot] = 1
				cat -= 1
			else:
				pass
			print(availability)
			
	for i in $VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Furnitures/VBoxContainer/GridContainer.get_children():
		if PlayerprogressSavefile.inventory_furniture[i.get_index()]["count"] == 0:
			i.visible = false
		else:
			i.find_child("Label").text = str(PlayerprogressSavefile.inventory_furniture[i.get_index()]["count"])
	#i in PlayerprogressSavefile.inventory_furniture:
		#PlayerprogressSavefile.inventory_furniture[i]["count"]
	set_physics_process(false)
	
func _physics_process(_delta: float) -> void:
	if $FurnitureQueue.get_child(0).get_child(0).get_overlapping_areas() == []:
		$FurnitureQueue.get_child(0).set_modulate(Color.WHITE)
		confirmable = true
	else:
		confirmable = false
		$FurnitureQueue.get_child(0).set_modulate(Color.RED)
	snap_furnitures_to_floor()
	if Input.is_action_just_released("touch"):
		set_physics_process(false)
func _on_furn_button_down(furniture) -> void:
	#move to confirm
	
	#move to confirm
	furniture_index = furniture
	
	new_or_edit = "new"
	$Panel.visible = true
	new_placement = load(str(PlayerprogressSavefile.inventory_furniture[furniture]["furniture_scene"]))
	furniture_name = PlayerprogressSavefile.inventory_furniture[furniture]["furniture_scene"]
	$FurnitureQueue.add_child(new_placement.instantiate())
	$FurnitureQueue.get_child(0).get_child(0).area_entered.connect(_area_entered_room)
	if tween:
		tween.kill
	tween = create_tween()
	tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0,0.1)
	set_physics_process(true)
	
func snap_furnitures_to_floor():
	$RayDown.position = get_viewport().get_mouse_position()
	$RayDown/RayCast2D.force_raycast_update()
	$FurnitureQueue.get_child(0).position = $RayDown/RayCast2D.get_collision_point()
	$Panel.position = $RayDown/RayCast2D.get_collision_point() - Vector2(320,0)
	
func _on_move_button_down() -> void:
	set_physics_process(true)

func _on_cancel_pressed() -> void:
	if tween:
		tween.kill
	tween = create_tween()
	match new_or_edit:
		"new":
			tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
			$FurnitureQueue.get_child(0).queue_free()
			$Panel.visible = false
		"edit":
			tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
			PlayerprogressSavefile.rooms[0].remove_at(furniture_name)
			$FurnitureContainer.get_child(furniture_name).queue_free()
			$FurnitureQueue.get_child(0).queue_free()
			PlayerprogressSavefile.save_data()
			$Panel.visible = false

func _area_entered_room(area):
	pass
func _button_down_furniture(source):
	new_or_edit = "edit"
	$FurnitureQueue.add_child($FurnitureContainer.get_child(source).duplicate())
	$Panel.visible = true
	set_physics_process(true)
	snap_furnitures_to_floor()
	$FurnitureContainer.get_child(source).visible = false
	$FurnitureContainer.get_child(source).get_child(0).set_collision_layer(2)
	furniture_name = source

func _on_confirm_pressed() -> void:
	if tween:
		tween.kill
	tween = create_tween()
	tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
	if confirmable:
		match new_or_edit:
			"new":
				PlayerprogressSavefile.inventory_furniture[furniture_index]["count"] -= 1
				$VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Furnitures/VBoxContainer/GridContainer.get_child(furniture_index).find_child("Label").text = str(PlayerprogressSavefile.inventory_furniture[furniture_index]["count"])
				if PlayerprogressSavefile.inventory_furniture[furniture_index]["count"] == 0:
					$VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Furnitures/VBoxContainer/GridContainer.get_child(furniture_index).visible = false
				print(PlayerprogressSavefile.inventory_furniture[furniture_index]["count"])
				var new_furniture_cat_spawn : Array
				new_furniture_cat_spawn.resize($FurnitureQueue.get_child(0).get_meta("cat_spawn_count"))
				for i in range(new_furniture_cat_spawn.size()):
					new_furniture_cat_spawn[i] = 0
				print(new_furniture_cat_spawn)
				$FurnitureQueue.get_child(0).queue_free()
				$FurnitureContainer.add_child(new_placement.instantiate())
				$FurnitureContainer.get_child(-1).position  = $FurnitureQueue.get_child(0).position
				$FurnitureContainer.get_child(-1).add_child(Button.new())
				$FurnitureContainer.get_child(-1).get_child(3).button_down.connect(_button_down_furniture.bind($FurnitureContainer.get_child(-1).get_index()))
				$FurnitureContainer.get_child(-1).get_child(3).pivot_offset = Vector2(4,4)
				$FurnitureContainer.get_child(-1).get_child(3).scale = Vector2(50,50)
				$FurnitureContainer.get_child(-1).get_child(3).keep_pressed_outside = true
				PlayerprogressSavefile.rooms[0].append([{"furniture":str(furniture_name), "pos":$FurnitureContainer.get_child(-1).position, "cat_spawn": new_furniture_cat_spawn}])
				PlayerprogressSavefile.save_data()
				$Panel.visible = false
				print(PlayerprogressSavefile.rooms[0])
			"edit":
				$FurnitureContainer.get_child(furniture_name).position = $FurnitureQueue.get_child(0).position
				$FurnitureQueue.get_child(0).queue_free()
				$FurnitureContainer.get_child(furniture_name).visible = true
				$FurnitureContainer.get_child(furniture_name).get_child(0).set_collision_layer(1)
				PlayerprogressSavefile.rooms[0][furniture_name][0]["pos"] = $FurnitureContainer.get_child(furniture_name).position
				PlayerprogressSavefile.save_data()
				$Panel.visible = false
				#[[[{ "furniture": "res://extra assets/Furnitures/furniture_3.tscn", "pos": (288.0, 1308.0), "cat_spawn": [0] }]],[]]

func _on_edit_toggled(toggled_on: bool) -> void:
	if tween:
		tween.kill
	tween = create_tween()
	$VBoxContainer/HBoxContainer/MarginContainer3/HBoxContainer/DropDown.button_pressed = true
	if toggled_on == true:
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
		for i in $FurnitureContainer.get_children():
			i.add_child(Button.new())
			i.get_child(3).button_down.connect(_button_down_furniture.bind(i.get_index()))
			i.get_child(3).pivot_offset = Vector2(4,4)
			i.get_child(3).scale = Vector2(50,50)
			i.get_child(3).keep_pressed_outside = true
	else: 
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0,0.1)
		for i in $FurnitureContainer.get_children():
				i.get_child(3).queue_free()


func _on_drop_down_toggled(toggled_on: bool) -> void:
	if tween:
		tween.kill
	tween = create_tween()
	if toggled_on == true:
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
	else:
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.15,0.1)
