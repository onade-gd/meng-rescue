extends Node2D

@export var money_1 : int = 0
@export var money_2 : int = 0
@export var level_progress : int = 0

@export var booster_magnet : int = 0
@export var booster_invincible : int = 0
@export var booster_heart : int = 0

@export var last_lobby : String

@export var inventory_cats : Dictionary = {  #needs work
	"cat_1" : {
		"count": 0, 
		"image": "res://icon.svg",
		"cat_1_scene" : "res://PLACEHOLDER PLEASE REPLACE",

	},
	"cat_2" : 0,
	"cat_3" : 0
}

@export var inventory_furniture : Dictionary = {
	0 : {
		"count" : 2,
		"image": "res://assets/kasur/awan.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_1.tscn",
		"value" :50
		},
	1 : {
		"count" : 5,
		"image": "res://assets/kasur/bunga.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_2.tscn",
		"value" :50
		},
	2 : {
		"count" : 3,
		"image": "res://assets/kasur/kodok.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_3.tscn",
		"value" :50
		},
	3 : {
		"count" : 1,
		"image": "res://assets/kasur/ori 2.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_4.tscn",
		"value" :50
		},
	4 : {
		"count" : 0,
		"image": "res://assets/kasur/ori 3.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_5.tscn",
		"value" :50
		},
	5 : {
		"count" : 0,
		"image": "res://assets/kasur/ori.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_6.tscn",
		"value" :50
		},
	6 : {
		"count" : 0,
		"image": "res://assets/kasur/pisang.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_7.tscn",
		"value" :50
		},
	7 : {
		"count" : 0,
		"image": "res://assets/kasur/rumah.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_8.tscn",
		"value" :50
		},
	8 : {
		"count" : 0,
		"image": "res://assets/kasur/sofa.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_9.tscn",
		"value" :50
		},
}

@export var rooms : Array = [    #array because i dont know how to handle new instances of rooms with unique names (or not) in a dictionary
	[
		
	]                                 #/
]

@export var stages : Dictionary = {
	0 : {"stars": 0.0},
	1 : {"stars": 0.0},
	2 : {"stars": 0.0},
	3 : {"stars": 0.0},
	4 : {"stars": 0.0},
	5 : {"stars": 0.0},
	6 : {"stars": 0.0},
	7 : {"stars": 0.0},
	8 : {"stars": 0.0},
	9 : {"stars": 0.0},
	10 : {"stars": 0.0},
	11 : {"stars": 0.0},
	12 : {"stars": 0.0},
	13 : {"stars": 0.0},
	14 : {"stars": 0.0},
	15 : {"stars": 0.0},
	16 : {"stars": 0.0},
	17 : {"stars": 0.0},
	18 : {"stars": 0.0},
	19 : {"stars": 0.0},
	20 : {"stars": 0.0},
	21 : {"stars": 0.0},
	22 : {"stars": 0.0},
	23 : {"stars": 0.0},
	24 : {"stars": 0.0},
	25 : {"stars": 0.0}
}

func save_data():
	var file = FileAccess.open("user://file1.save", FileAccess.WRITE)
	file.store_var(stages)
	file.store_var(rooms)
	file.store_var(money_1)
	file.store_var(money_2)
	file.store_var(inventory_furniture)
	
func load_data():
	if FileAccess.file_exists("user://file1.save"):
		var file = FileAccess.open("user://file1.save", FileAccess.READ)
		stages = file.get_var()
		rooms = file.get_var()
		money_1 = file.get_var()
		money_2 = file.get_var()
		inventory_furniture = file.get_var()
	else:
		print("no save here")
# array format -> cats = [<cat type>, <location>]   |     furniture in inventory = [<furniture>, <amount>]
