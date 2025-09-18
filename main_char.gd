extends CharacterBody2D
signal scoresignal()
signal hp()
var alive = true
var health = 3
var _prev_position:Vector2 = Vector2.ZERO
@export var speed : Vector2
func _process(delta: float) -> void:
	speed = (_prev_position - global_position)/delta
	_prev_position = global_position
	print(speed)
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
	if alive:
		var controller = get_parent().find_child("MainCharController").global_position
		global_position = lerp(global_position,controller, 10.0 * delta)
	else:
		get_node(".").queue_free()

func score(value):
	scoresignal.emit(value)
	
func damage(value):
	health -= value
	hp.emit(health)
	
