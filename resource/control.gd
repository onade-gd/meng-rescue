extends Control
var pos
var swipable : bool = true
func _process(delta: float) -> void:
	if swipable == true:
		if Input.is_action_just_pressed("touch"):
			pos = get_viewport().get_mouse_position()
		if Input.is_action_pressed("touch"):
			var new_pos = get_viewport().get_mouse_position()
			var total_pos = new_pos - pos
			if total_pos.y > 50:
				Input.action_press("ui_down")
				Input.action_release("ui_down")
				swipable = false
			if total_pos.y < -50:
				Input.action_press("ui_up")
				Input.action_release("ui_up")
				swipable = false
			if total_pos.x > 50:
				Input.action_press("ui_right")
				Input.action_release("ui_right")
				swipable = false
				print("right")
			if total_pos.x < -50:
				Input.action_press("ui_left")
				Input.action_release("ui_left")
				swipable = false
				print("left")
				
	if Input.is_action_just_released("touch"):
		swipable = true
