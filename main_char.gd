extends CharacterBody2D
signal scoresignal()
signal hp()
var alive = true
var health = 3
var _prev_position:Vector2 = Vector2.ZERO
@export var jump = false
@export var jump_able = true
@export var speed : Vector2
@export var duck = false
@export var duck_able = true
func _process(delta: float) -> void:
 	# - speed calculation
	speed = (_prev_position - global_position)/delta
	_prev_position = global_position
	# - animation control
	if Input.is_action_just_pressed("ui_up") and jump_able == true:
		$AnimationPlayer.play("jump")
	if Input.is_action_just_pressed("ui_down") and duck_able == true and jump == false:
		$AnimationPlayer.play("duck",-1,1.5)
		print("down")
	if $AnimationPlayer.current_animation != "jump":
		if $AnimationPlayer.current_animation != "duck":
			if speed.x < -5:
				$Sprite2D.flip_h = false
				$AnimationPlayer.play("leftright")
			elif speed.x > 5:
				$Sprite2D.flip_h = true
				$AnimationPlayer.play("leftright")
			else:
				$AnimationPlayer.play("idle")
	
	if health == 0:
		alive = false
	# - interpolation control
	if alive:
		var controller = get_parent().find_child("MainCharController").global_position
		global_position = lerp(global_position,controller, 10.0 * delta)
	else:
		get_node(".").queue_free()

func score(value):
	$AnimationPlayer.play()
	scoresignal.emit(value)
	
func damage(value):
	health -= value
	hp.emit(health)
	
