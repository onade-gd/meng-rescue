extends Control
var new_placement
var tween
var furniture_name
func _ready() -> void:
	for furnitures in PlayerprogressSavefile.rooms[0]:
		print(furnitures)
		$FurnitureContainer.add_child(load(furnitures[0]["furniture"]).instantiate())
		$FurnitureContainer.get_child(-1).position = Vector2(furnitures[0]["pos"])
	set_physics_process(false)
func _physics_process(_delta: float) -> void:
	snap_furnitures_to_floor()
	if Input.is_action_just_released("touch"):
		set_physics_process(false)
func _on_furn_button_down(furniture) -> void:
	$Panel.visible = true
	new_placement = load(str(furniture))
	furniture_name = furniture
	$FurnitureQueue.add_child(new_placement.instantiate())
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

func _on_confirm_pressed() -> void:
	$FurnitureQueue.get_child(0).queue_free()
	$FurnitureContainer.add_child(new_placement.instantiate())
	$FurnitureContainer.get_child(-1).position  = $FurnitureQueue.get_child(0).position
	PlayerprogressSavefile.rooms[0].append([{"furniture":str(furniture_name), "pos":$FurnitureContainer.get_child(-1).position}])
	PlayerprogressSavefile.save_data()
	if tween:
		tween.kill
	tween = create_tween()
	tween.tween_property($VBoxContainer/TabContainer,"size_flags_stretch_ratio",0.75,0.1)
	$Panel.visible = false
	print(PlayerprogressSavefile.rooms[0])
