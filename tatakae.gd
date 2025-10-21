extends Node2D
var stop : float = 1.0
func _physics_process(delta: float) -> void:
	translate(Vector2.UP*stop*600*delta)

func _on_main_char_finishline() -> void:
	stop = 0.0
