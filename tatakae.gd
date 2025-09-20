extends Node2D

func _process(delta: float) -> void:
	translate(Vector2.UP*500*delta)
