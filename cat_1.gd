extends Area2D
var alive = true
@onready var animation = $AnimationPlayer
func _process(delta: float) -> void:
	if alive:
		animation.play("Cat1")
		translate(Vector2.DOWN*150*delta)
	else:
		animation.play("jump")
		await animation.animation_finished
		get_node(".").queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainChar" :
		body.score(1)
		alive = false
