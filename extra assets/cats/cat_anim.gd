extends Node2D
func _ready() -> void:
	if get_parent().name.contains("stand"):
		$HeadSprite.visible = false
		$AnimationPlayer.play("idle")
	else:
		$StandSprite.visible = false
		
