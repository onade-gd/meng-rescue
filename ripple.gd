extends Node2D
var tween = create_tween()
func _process(delta: float) -> void:
	translate(Vector2.DOWN*150*delta)
	tween.tween_property(self,"modulate:a",0,1)
	if get_node(".").modulate.a == 0:
		get_node(".").queue_free()
