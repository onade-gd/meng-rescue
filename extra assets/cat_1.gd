extends Area2D
var alive = true
var variants = (randi_range(0,7) * 243)
func _ready() -> void:
	$Sprite2D.set_region_rect(Rect2(variants,0.0,243.0,993.0))
	
func _process(delta: float) -> void:
	if alive:
		$AnimationPlayer.play("Cat1")
	else:
		$CollisionShape2D.disabled = true
		$AnimationPlayer.play("jump")
		await $AnimationPlayer.animation_finished
		get_node(".").queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainChar" :
		body.score(1)
		alive = false
		match randi_range(0,2):
			1:$AudioStreamPlayer.stream = preload("res://audio/cat-meow-1-fx-323465.ogg")
			2:$AudioStreamPlayer.stream = preload("res://audio/cat-meow-4-fx-306180.ogg")
			3:$AudioStreamPlayer.stream = preload("res://audio/cat-meow-7-fx-306186.ogg")
		$AudioStreamPlayer.play()
