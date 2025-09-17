extends Control
signal summon
@onready var Character = $MainChar
var score : int = 0 
func _on_timer_timeout() -> void:
	summon.emit()
	print("meow")
	print(score)
	
func _on_main_char_scoresignal(value) -> void:
	score += value
	$UI/VBoxContainer/MarginContainer/Score.text = str("score:", score)
	
func _on_main_char_hp(value) -> void:
	$UI/VBoxContainer/MarginContainer3/Health.text = str("health:",value)
