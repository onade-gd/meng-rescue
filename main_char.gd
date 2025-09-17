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
	if speed in range(1.0,-1.0):
		$AnimationPlayer.play("idle")
	#elif speed in range(1.1,70) or speed in rang
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
	
