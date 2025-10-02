extends CharacterBody2D
signal scoresignal()
signal hp()
signal finishline
var alive = true
var health = 3
var _prev_position : Vector2 = Vector2.ZERO
signal direction()
@export var jump = false
@export var jump_able = true
@export var speed : Vector2
@export var duck = false
@export var duck_able = true
@export var winlose : int = 0
var controlable : bool = true
func _process(delta: float) -> void:
 	# - speed calculation
	speed = (_prev_position - global_position)/delta
	_prev_position = global_position
	# - animation control
	if alive:
		var controller = get_parent().find_child("MainCharController").global_position
		global_position = lerp(global_position,controller, 10.0 * delta)
		if controlable == true:
			$kicir.play("spin")
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
	else:
		finish("death")
	if health <= 0:
		alive = false
	
func score(value):
	scoresignal.emit(value)
	
func damage(value):
	health -= value
	
	hp.emit(health)
	
func finish(endcondition):
	controlable = false
	finishline.emit()
	$CPUParticles2D.emitting = false
	match endcondition:
		"mapend": 
			if winlose == 1: $AnimationPlayer.play("win")
			elif winlose == 2: $AnimationPlayer.play("lose")
			else: $AnimationPlayer.play("lose")
			$kicir.play("winlose")
		"death":
			$AnimationPlayer.play("death")
			$kicir.play("death")
			await $AnimationPlayer.animation_finished
			queue_free()

func _on_hitbox_front_body_entered(body: Node2D) -> void:
	if body.get_parent().name == "stage":
		health -= 3
		print(health)

func _on_hitbox_left_body_entered(body: Node2D) -> void:
	if body.get_parent().name == "stage":
		health -= 1
		direction.emit("left")
		print(health)
		$sweat.play("hurt")

func _on_hitbox_right_body_entered(body: Node2D) -> void:
	if body.get_parent().name == "stage":
		health -= 1
		direction.emit("right")
		print(health)
		$sweat.play("hurt")
	
