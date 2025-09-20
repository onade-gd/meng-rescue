extends Area2D

func _process(delta: float) -> void:
	translate(Vector2.DOWN*500*delta)
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainChar":
		body.damage(1)
		get_node(".").queue_free()
