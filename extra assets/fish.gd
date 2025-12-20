extends Area2D
var alive = true
func _process(delta: float) -> void:
	if alive:
		$AnimationPlayer.play("fishspin")
	else:
		get_node(".").queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainChar" :
		$pling.play()
		PlayerprogressSavefile.money_1 += 10
		PlayerprogressSavefile.save_data()
		alive = false
