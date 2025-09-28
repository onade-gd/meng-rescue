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
			print(total_pos.y)
			if total_pos.y > 100:
				Input.action_press("ui_down")
				Input.action_release("ui_down")
				swipable = false
			if total_pos.y < -100:
				Input.action_press("ui_up")
				Input.action_release("ui_up")
				swipable = false
			if total_pos.x > 100:
				Input.action_press("ui_right")
				Input.action_release("ui_right")
				swipable = false
			if total_pos.x < -100:
				Input.action_press("ui_left")
				Input.action_release("ui_left")
				swipable = false
				
	if Input.is_action_just_released("touch"):
		print("yes")
		swipable = true
