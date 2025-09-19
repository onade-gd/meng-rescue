extends Node2D

@onready var cat = preload("res://Cat1.tscn")
@onready var obstacle1 = preload("res://obstacle_1.tscn")
var summonblock : int
var summonpos
var spawnentity

func _on_main_summon() -> void:
	summonblock = randi_range(1,3)
	spawnentity = randi_range(1,2)
	match summonblock:
		1: summonpos = $Area2D.global_position
		2: summonpos = $Area2D2.global_position
		3: summonpos = $Area2D3.global_position
	
	if spawnentity == 2:
		var catspawn = cat.instantiate()
		get_tree().current_scene.add_child(catspawn)
		catspawn.global_position = summonpos
		
	else:
		var obstacle = obstacle1.instantiate()
		get_tree().current_scene.add_child(obstacle)
		obstacle.global_position = summonpos
