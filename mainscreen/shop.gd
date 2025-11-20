extends Control

func _ready() -> void:
	$VBoxContainer/MarginContainer/HBoxContainer2/TextureRect/HBoxContainer/Money2.text = str(PlayerprogressSavefile.money_2)
	$VBoxContainer/MarginContainer/HBoxContainer2/TextureRect2/HBoxContainer/Money1.text = str(PlayerprogressSavefile.money_1)
	var furnitures = $VBoxContainer/MarginContainer2/HBoxContainer/ScrollContainer/VBoxContainer/Panel2/MarginContainer/Furnitures
	$VBoxContainer/MarginContainer2/HBoxContainer/ScrollContainer/VBoxContainer/Panel2/MarginContainer/Furnitures.columns = 3
	for i in PlayerprogressSavefile.inventory_furniture:
		furnitures.add_child($PresetToCopyCuzImLazy/TextureRect.duplicate())
		furnitures.get_child(-1).texture = load(PlayerprogressSavefile.inventory_furniture[i]["image"])
		furnitures.get_child(-1).get_child(0).pressed.connect(furniture_chosen.bind(i))


func furniture_chosen(id):
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(PlayerprogressSavefile.last_lobby)
