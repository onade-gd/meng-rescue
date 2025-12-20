extends Control
var new_placement
var tween
var furniture_name
var furniture_index
var confirmable: bool
var new_or_edit : String
var current_room 
var cat
var model = 0
var cat_count
# save format: [[[[{ "furniture": "res://extra assets/Furnitures/furniture_3.tscn", "pos": (288.0, 1308.0), "cat_spawn": [0] }]],[]],[{cats:[]}]]     outdated ref

func _ready() -> void:
	current_room = get_parent().get_index()
	print(get_owner())
	model = PlayerprogressSavefile.rooms[current_room][2]["model"] #match room style to save
	match model:
		0: $Model.add_child(load("res://extra assets/rooms/room_1.tscn").instantiate())
		1: $Model.add_child(load("res://extra assets/rooms/room_2.tscn").instantiate())
		2: $Model.add_child(load("res://extra assets/rooms/room_3.tscn").instantiate())
		
	var cat_list : Array
	cat_count = PlayerprogressSavefile.rooms[current_room][1][0]   
	for i in cat_count:
		for x in cat_count[i]["count"]:
			cat_list.append(PlayerprogressSavefile.inventory_cats[i]["cat_scene"]) #add scenes of cats from save file to a temporary list
	print("cat list:   ", cat_list)
	cat = cat_list.size()
	$VBoxContainer/HBoxContainer/MarginContainer3/HBoxContainer.set_mouse_filter(2)
	$VBoxContainer.set_mouse_filter(2)
	var total_furn_spot : int = 0
	var availability : Array
	var cat_in_queue = cat-1

	availability.resize($Model.get_child(0).get_child(3).get_child_count())
	for i in range(availability.size()):
		availability[i] = 0
		# save format: [[[[{ "furniture": "res://extra assets/Furnitures/furniture_3.tscn", "pos": (288.0, 1308.0), "cat_spawn": [0] }]],[]],[{cats:[]}]]     all this and similar below are outdated reference
	for furnitures in PlayerprogressSavefile.rooms[current_room][0]:
		$FurnitureContainer.add_child(load(furnitures[0]["furniture"]).instantiate())
		$FurnitureContainer.get_child(-1).position = Vector2(furnitures[0]["pos"])
	for i in $FurnitureContainer.get_child_count():
		total_furn_spot += $FurnitureContainer.get_child(i).find_child("Sleep").get_child_count()
	print("total furn spot:" ,total_furn_spot)
	while cat > 0:
		if total_furn_spot > 0:
			var step1_rand_furn = randi_range(0, $FurnitureContainer.get_child_count()-1)
			var step2_rand_spot = randi_range(0,$FurnitureContainer.get_child(step1_rand_furn).find_child("Sleep").get_child_count()-1)
				# save format: [[[[{ "furniture": "res://extra assets/Furnitures/furniture_3.tscn", "pos": (288.0, 1308.0), "cat_spawn": [0] }]],[]],[{cats:[]}]]     outdated ref
			if PlayerprogressSavefile.rooms[current_room][0][step1_rand_furn][0]["cat_spawn"][step2_rand_spot] == 0:
				$FurnitureContainer.get_child(step1_rand_furn).get_child(2).get_child(step2_rand_spot).get_child(0).add_child(load(cat_list.get(cat_in_queue)).instantiate())
				PlayerprogressSavefile.rooms[current_room][0][step1_rand_furn][0]["cat_spawn"][step2_rand_spot] = 1
				cat_in_queue -= 1
				cat -= 1
				total_furn_spot -= 1
				print("total furn spot:",total_furn_spot , "  cats left:",cat)
				print(step1_rand_furn, " ",step2_rand_spot)
			else:
				pass
		else: 
			var rand_spot = randi_range(0,$Model.get_child(0).get_child(3).get_child_count()-1)
			if availability[rand_spot] == 0:
				$Model.get_child(0).get_child(3).get_child(rand_spot).get_child(0).add_child(load(cat_list.get(cat_in_queue)).instantiate())
				availability[rand_spot] = 1
				cat_in_queue -= 1
				cat -= 1
			else:
				pass
			print(availability)

	for i in $VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Furnitures/VBoxContainer/GridContainer.get_children():
		if PlayerprogressSavefile.inventory_furniture[i.get_index()]["count"] <= 0:
			i.visible = false
		else:
			i.find_child("Label").text = str(PlayerprogressSavefile.inventory_furniture[i.get_index()]["count"])
	#i in PlayerprogressSavefile.inventory_furniture:
		#PlayerprogressSavefile.inventory_furniture[i]["count"]
	var cats_grid = $VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Cats/VBoxContainer/GridContainer
	for i in PlayerprogressSavefile.inventory_cats:
		cats_grid.add_child($PresetToCopyCuzImLazy/TextureRect.duplicate())
		cats_grid.get_child(-1).texture = load(PlayerprogressSavefile.inventory_cats[i]["image"])
		cats_grid.get_child(-1).get_child(1).pressed.connect(add_cat.bind(i))
		cats_grid.get_child(-1).get_child(0).pressed.connect(negate_cat.bind(i))
		cats_grid.get_child(-1).get_child(2).text = str(PlayerprogressSavefile.inventory_cats[i]["count"])
	set_physics_process(false)
	
func negate_cat(id):
	if PlayerprogressSavefile.rooms[current_room][1][0][id]["count"] > 0:
		PlayerprogressSavefile.rooms[current_room][1][0][id]["count"] -= 1
		PlayerprogressSavefile.inventory_cats[id]["count"] += 1
	$VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Cats/VBoxContainer/GridContainer.get_child(id).get_child(2).text = str(PlayerprogressSavefile.inventory_cats[id]["count"])
	PlayerprogressSavefile.save_data()

func add_cat(id):
	if PlayerprogressSavefile.inventory_cats[id]["count"] > 0:
		PlayerprogressSavefile.rooms[current_room][1][0][id]["count"] += 1
		PlayerprogressSavefile.inventory_cats[id]["count"] -= 1
	$VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Cats/VBoxContainer/GridContainer.get_child(id).get_child(2).text = str(PlayerprogressSavefile.inventory_cats[id]["count"])
	PlayerprogressSavefile.save_data()
	
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
			PlayerprogressSavefile.inventory_furniture[PlayerprogressSavefile.rooms[current_room][0][furniture_index][0]["furniture_id"]]["count"] += 1
			#PlayerprogressSavefile.inventory_furniture[PlayerprogressSavefile.rooms[i][0][x][0]["cat_spawn"][y] += 1
			tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
			$VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Furnitures/VBoxContainer/GridContainer.get_child(PlayerprogressSavefile.rooms[current_room][0][furniture_index][0]["furniture_id"]).get_child(1).text = str(PlayerprogressSavefile.inventory_furniture[PlayerprogressSavefile.rooms[current_room][0][furniture_index][0]["furniture_id"]]["count"])
			if PlayerprogressSavefile.inventory_furniture[PlayerprogressSavefile.rooms[current_room][0][furniture_index][0]["furniture_id"]]["count"] > 0:
				$VBoxContainer/HBoxContainer/MarginContainer3/TabContainer/Furnitures/VBoxContainer/GridContainer.get_child(PlayerprogressSavefile.rooms[current_room][0][furniture_index][0]["furniture_id"]).visible = true
			$FurnitureContainer.get_child(furniture_index).queue_free()# save format: [[[[{ "furniture": "res://extra assets/Furnitures/furniture_3.tscn", "pos": (288.0, 1308.0), "cat_spawn": [0] }]],[]],[{cats:[]}]]    
																	  #[room[furnitureobject[uselessbracket{array    outdated reference
			var current_index = furniture_index +1
			var to_shift : Array
			PlayerprogressSavefile.rooms[current_room][0].remove_at(furniture_index)
			while current_index < $FurnitureContainer.get_child_count():   #gets an array of the children that comes after this node
				var next_index = $FurnitureContainer.get_child(current_index)
				to_shift.append(next_index)
				current_index += 1
			for i in to_shift:                 # changes the button's argument for each node to the new argument
				i.get_child(3).button_down.disconnect(_button_down_furniture)
				i.get_child(3).button_down.connect(_button_down_furniture.bind(i.get_index()-1))
			$FurnitureQueue.get_child(0).queue_free()
			PlayerprogressSavefile.save_data()
			$Panel.visible = false

func _area_entered_room(area):
	pass
func _button_down_furniture(source):
	print("source:   ",source)
	new_or_edit = "edit"
	$FurnitureQueue.add_child($FurnitureContainer.get_child(source).duplicate())
	$Panel.visible = true
	set_physics_process(true)
	snap_furnitures_to_floor()
	$FurnitureContainer.get_child(source).visible = false
	$FurnitureContainer.get_child(source).get_child(0).set_collision_layer(2)
	furniture_index = source

func _on_confirm_pressed() -> void:
	print("furniture index:   ", furniture_index)
	if PlayerprogressSavefile.inventory_furniture[furniture_index]["count"] <= 0:
		confirmable = false
	elif PlayerprogressSavefile.inventory_furniture[furniture_index]["count"] > 0 and confirmable == true:
		confirmable = true
	if confirmable == true:
		if tween:
			tween.kill
		tween = create_tween()
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
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
				if $Edit.button_pressed == true:
					$FurnitureContainer.get_child(-1).add_child(Button.new())
					$FurnitureContainer.get_child(-1).get_child(3).button_down.connect(_button_down_furniture.bind($FurnitureContainer.get_child(-1).get_index()))
					$FurnitureContainer.get_child(-1).get_child(3).pivot_offset = Vector2(4,4)
					$FurnitureContainer.get_child(-1).get_child(3).scale = Vector2(50,50)
					$FurnitureContainer.get_child(-1).get_child(3).keep_pressed_outside = true
				PlayerprogressSavefile.rooms[current_room][0].append([{"furniture_id": furniture_index, "furniture":str(furniture_name), "pos":$FurnitureContainer.get_child(-1).position, "cat_spawn": new_furniture_cat_spawn}])
				PlayerprogressSavefile.save_data()
				$Panel.visible = false
				print(PlayerprogressSavefile.rooms[current_room][0])
			"edit":
				$FurnitureContainer.get_child(furniture_index).position = $FurnitureQueue.get_child(0).position
				$FurnitureQueue.get_child(0).queue_free()
				$FurnitureContainer.get_child(furniture_index).visible = true
				$FurnitureContainer.get_child(furniture_index).get_child(0).set_collision_layer(1)
				PlayerprogressSavefile.rooms[current_room][0][furniture_index][0]["pos"] = $FurnitureContainer.get_child(furniture_index).position
				PlayerprogressSavefile.save_data()
				$Panel.visible = false
				# save format: [[[{ "furniture": "res://extra assets/Furnitures/furniture_3.tscn", "pos": (288.0, 1308.0), "cat_spawn": [0] }]],[]]    [room[furnitureobject[uselessbracket{array
					#outdated reference
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
		get_parent().get_parent().get_parent().set_mouse_filter(2)
	else: 
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0,0.1)
		for i in $FurnitureContainer.get_children():
				i.get_child(3).queue_free()
		get_parent().get_parent().get_parent().set_mouse_filter(1)

func _on_drop_down_toggled(toggled_on: bool) -> void:
	if tween:
		tween.kill
	tween = create_tween()
	if toggled_on == true:
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.75,0.1)
	else:
		tween.tween_property($VBoxContainer/HBoxContainer,"size_flags_stretch_ratio",0.15,0.1)

func _on_roomtype_pressed(extra_arg_0: int) -> void:
	if PlayerprogressSavefile.rooms[current_room][0] != []:
		pass
	else:
		$Model.get_child(0).queue_free()
		match extra_arg_0:
			0:$Model.add_child(load("res://extra assets/rooms/room_1.tscn").instantiate())
			1:$Model.add_child(load("res://extra assets/rooms/room_2.tscn").instantiate())
			2:$Model.add_child(load("res://extra assets/rooms/room_3.tscn").instantiate())
		PlayerprogressSavefile.rooms[current_room][2]["model"] = extra_arg_0
		PlayerprogressSavefile.save_data()
