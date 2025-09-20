extends Area2D
var alive = true
var variants = (randi_range(0,7) * 243)
func _ready() -> void:
	$Sprite2D.set_region_rect(Rect2(variants,0.0,243.0,993.0))
	
func _process(delta: float) -> void:
	if alive:
		$AnimationPlayer.play("Cat1")
		translate(Vector2.DOWN*500*delta)
	else:
		$AnimationPlayer.play("jump")
		await $AnimationPlayer.animation_finished
		get_node(".").queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainChar" :
		body.score(1)
		alive = false
