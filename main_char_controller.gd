extends CharacterBody2D
var pos = clampi(2,1,3)
func _process(delta: float) -> void:
	pos = clampi(pos,1,3)
	match pos:
		1: global_position = Vector2(360,2200)
		2: global_position = Vector2(720,2200)
		3: global_position = Vector2(1080,2200)
	if Input.is_action_just_pressed("ui_left"):
		pos -= 1
	if Input.is_action_just_pressed("ui_right"):
		pos += 1

#var min_pos = 180.0
#var max_pos = 540.0
#func _physics_process(delta: float) -> void:
	#var time = delta / 1
	#time = clampf(time, 0.0,1.0)
	#if Input.is_action_just_pressed("ui_left"):
		#if global_position.x != min_pos:
			#global_position.x = lerp(global_position.x, global_position.x - 180.0, 1)
		#else:
			#pass
	#elif Input.is_action_just_pressed("ui_right"):
		#if global_position.x != max_pos:
			#global_position.x = lerp(global_position.x, global_position.x + 180.0, 1)
