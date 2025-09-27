extends Area2D
var levelcheck
func _on_body_entered(body: Node2D) -> void:
	body.finish("mapend")
	PlayerprogressSavefile.level_progress = get_parent().get_parent().get_meta("level")
	
