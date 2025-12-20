extends Control
var page :int = 1
var tween
	
func _ready() -> void:
	$rain.play()
	page_animation()

func _on_button_pressed() -> void:
	match page:
		1:
			page_animation()
			$TextureRect.texture = preload("res://assets/story/Story 2.png")
			page += 1
		2:
			page_animation()
			$TextureRect.texture = preload("res://assets/story/Story 3.png")
			PlayerprogressSavefile.first_times["first_login"] = false
			PlayerprogressSavefile.save_data()
			page += 1
		3:
			get_tree().change_scene_to_file("res://mainscreen/StagePicker.tscn")

func page_animation():
		if tween:
			tween.kill
		$TextureRect.position = Vector2(0,-13)
		tween = create_tween()
		tween.tween_property($TextureRect, "position", Vector2(0,-624),3.0)
		
func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event["pressed"] == true :
			$ClickIN.play()
		elif event["pressed"] == false :
			$ClickOUT.play()
