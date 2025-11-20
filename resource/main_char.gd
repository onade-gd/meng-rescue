extends CharacterBody2D
signal scoresignal()
signal hp()
signal finishline
var alive = true
var health = 3
var _prev_position : Vector2 = Vector2.ZERO
var invincible : bool = false
var invc_available :bool = false
signal direction()
@export var jump = false
@export var jump_able = true
@export var speed : Vector2
@export var duck = false
@export var duck_able = true
@export var winlose : int = 0
var controlable : bool = true

func _physics_process(delta: float) -> void:
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
	
func current_hp(value):
	health -= value
	if invc_available == true:
		i_frame()
	hp.emit(health)
	
func finish(endcondition):
	controlable = false
	finishline.emit(endcondition)
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
	if body.get_parent().get_parent().name == "StageParent":
		if invincible == true:
			if invc_available == true:
				i_frame()
				current_hp(1)
				$Timer.start(10.0)
				invc_available = false
			else:
				current_hp(3)
				$sweat.play("hurt")
				print("hit")
		else:
			current_hp(3)
			$sweat.play("hurt")
			print("hit")
func _on_hitbox_left_body_entered(body: Node2D) -> void:
	if body.get_parent().get_parent().name == "StageParent":
		if invincible == true:
			if invc_available == true:
				i_frame()
				$Timer.start(10.0)
				current_hp(1)
				invc_available = false
			else:
				current_hp(1)
				direction.emit("left")
				$sweat.play("hurt")
				print("hit")
		else:
			current_hp(1)
			direction.emit("left")
			$sweat.play("hurt")
			print("hit")
func _on_hitbox_right_body_entered(body: Node2D) -> void:
	if body.get_parent().get_parent().name == "StageParent":
		if invincible == true:
			if invc_available == true:
				i_frame()
				$Timer.start(10.0)
				current_hp(1)
				invc_available = false
			else:
				current_hp(1)
				direction.emit("right")
				$sweat.play("hurt")
				print("hit")
		else:
			current_hp(1)
			direction.emit("right")
			$sweat.play("hurt")
			print("hit")
		
func i_frame():
	$Timer2.start(5.0)
	$hitbox_front.set_deferred("monitoring",false)
	$hitbox_left.set_deferred("monitoring",false)
	$hitbox_right.set_deferred("monitoring",false)
	$".".set_modulate(Color.RED)

func _on_timer_timeout() -> void:
	invc_available = true

func _on_timer_2_timeout() -> void:
	$hitbox_front.set_deferred("monitoring",true)
	$hitbox_left.set_deferred("monitoring",true)
	$hitbox_right.set_deferred("monitoring",true)
	$".".set_modulate(Color.WHITE)
