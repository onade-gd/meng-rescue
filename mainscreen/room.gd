extends Control
var new_placement
var tween
var furniture_name
var confirmable: bool
var cat = 3
func _ready() -> void:
	for furnitures in PlayerprogressSavefile.rooms[0]:
		$FurnitureContainer.add_child(load(furnitures[0]["furniture"]).instantiate())
		$FurnitureContainer.get_child(-1).position = Vector2(furnitures[0]["pos"])
	while cat > 0:
		var step1 = randi_range(0, $FurnitureContainer.get_child_count()-1)
		var step2 = randi_range(0,$FurnitureContainer.get_child(step1).get_child(2).get_child_count()-1)
		$FurnitureContainer.get_child(step1).get_child(2).get_child(step2).add_child(preload("res://extra assets/Furnitures/furniture_cat.tscn").instantiate())
		PlayerprogressSavefile.rooms[0][step1]["cat_spawn"][step2] = 1
		
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
	$Panel.visible = true
	new_placement = load(str(furniture))
	furniture_name = furniture
	$FurnitureQueue.add_child(new_placement.instantiate())
	$FurnitureQueue.get_child(0).get_child(0).area_entered.connect(_area_entered_room)
	if tween:
		tween.kill
	tween = create_tween()
	tween.tween_property($VBoxContainer/TabContainer,"size_flags_stretch_ratio",0,0.1)
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
	tween.tween_property($VBoxContainer/TabContainer,"size_flags_stretch_ratio",0.75,0.1)
	$FurnitureQueue.get_child(0).queue_free()
	$Panel.visible = false

func _area_entered_room(area):
	confirmable = false

func _on_confirm_pressed() -> void:
	if confirmable:
		var new_furniture_cat_spawn : Array
		new_furniture_cat_spawn.resize(4)
		for i in range(new_furniture_cat_spawn.size()):
			new_furniture_cat_spawn[i] = 0
		print(new_furniture_cat_spawn)
		$FurnitureQueue.get_child(0).queue_free()
		$FurnitureContainer.add_child(new_placement.instantiate())
		$FurnitureContainer.get_child(-1).position  = $FurnitureQueue.get_child(0).position
		PlayerprogressSavefile.rooms[0].append([{"furniture":str(furniture_name), "pos":$FurnitureContainer.get_child(-1).position, "cat_spawn": new_furniture_cat_spawn}])
		PlayerprogressSavefile.save_data()
		if tween:
			tween.kill
		tween = create_tween()
		tween.tween_property($VBoxContainer/TabContainer,"size_flags_stretch_ratio",0.75,0.1)
		$Panel.visible = false
		print(PlayerprogressSavefile.rooms[0])
