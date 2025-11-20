extends Control
var to_buy
var furn_or_boost
var which_booster
func _ready() -> void:
	$VBoxContainer/MarginContainer/HBoxContainer2/TextureRect/HBoxContainer/Money2.text = str(PlayerprogressSavefile.money_2)
	$VBoxContainer/MarginContainer/HBoxContainer2/TextureRect2/HBoxContainer/Money1.text = str(PlayerprogressSavefile.money_1)
	var furnitures = $VBoxContainer/MarginContainer2/HBoxContainer/ScrollContainer/VBoxContainer/Panel2/Furnitures/Furnitures
	furnitures.columns = 3
	for i in PlayerprogressSavefile.inventory_furniture:
		furnitures.add_child($PresetToCopyCuzImLazy/TextureRect.duplicate())
		furnitures.get_child(-1).texture = load(PlayerprogressSavefile.inventory_furniture[i]["image"])
		furnitures.get_child(-1).get_child(0).pressed.connect(furniture_chosen.bind(i))

func furniture_chosen(id):
	$ConfirmBuy.visible = true
	$ConfirmBuy/Panel2/Display.texture = load(PlayerprogressSavefile.inventory_furniture[id]["image"])
	$ConfirmBuy/Panel2/Cost.text = str(PlayerprogressSavefile.inventory_furniture[id]["value"])
	furn_or_boost = "furniture"
	to_buy = id

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(PlayerprogressSavefile.last_lobby)

func _on_cancel_pressed() -> void:
	$ConfirmBuy.visible = false

func _on_buy_pressed() -> void:
	match furn_or_boost:
		"furniture":
			if PlayerprogressSavefile.money_1 < PlayerprogressSavefile.inventory_furniture[to_buy]["value"]:
				pass
			else:
				PlayerprogressSavefile.money_1 -= PlayerprogressSavefile.inventory_furniture[to_buy]["value"]
				$ConfirmBuy.visible = false
				PlayerprogressSavefile.inventory_furniture[to_buy]["count"] += 1
				PlayerprogressSavefile.save_data()
		"booster":
			match which_booster:
				0:
					if PlayerprogressSavefile.money_1 < PlayerprogressSavefile.booster_heart["count"]:
						pass
					else :
						PlayerprogressSavefile.booster_heart["count"] += 1
						PlayerprogressSavefile.money_1 -= PlayerprogressSavefile.booster_heart["value"]
				1:
					if PlayerprogressSavefile.money_1 < PlayerprogressSavefile.booster_invincible["count"]:
						pass
					else :
						PlayerprogressSavefile.booster_invincible["count"] += 1
						PlayerprogressSavefile.money_1 -= PlayerprogressSavefile.booster_invincible["value"]
				2:
					if PlayerprogressSavefile.money_1 < PlayerprogressSavefile.booster_magnet["count"]:
						pass
					else :
						PlayerprogressSavefile.booster_magnet["count"] += 1
						PlayerprogressSavefile.money_1 -= PlayerprogressSavefile.booster_magnet["value"]

func _on_boost_pressed(extra_arg_0: int) -> void:
	furn_or_boost = "booster"
	which_booster = extra_arg_0
	$ConfirmBuy.visible = true
	
	match extra_arg_0:
		0:
			$ConfirmBuy/Panel2/Display.texture = load(PlayerprogressSavefile.booster_heart["image"])
			$ConfirmBuy/Panel2/Cost.text = str(PlayerprogressSavefile.booster_heart["value"])
		1:
			$ConfirmBuy/Panel2/Display.texture = load(PlayerprogressSavefile.booster_invincible["image"])
			$ConfirmBuy/Panel2/Cost.text = str(PlayerprogressSavefile.booster_invincible["value"])
		2:
			$ConfirmBuy/Panel2/Display.texture = load(PlayerprogressSavefile.booster_magnet["image"])
			$ConfirmBuy/Panel2/Cost.text = str(PlayerprogressSavefile.booster_magnet["value"])
