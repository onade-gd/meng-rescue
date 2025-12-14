extends Node2D


@export var money_1 : int = 10000
@export var money_2 : int = 300
@export var level_progress : int = 0

@export var first_times : Dictionary = {
	"first_login": true,
	"first_tutorial": true
}

@export var booster_magnet : Dictionary = {
	"count" : 0,
	"image" : "res://assets/boosters/Sedot.png",
	"value" : 50,
}
@export var booster_invincible : Dictionary = {
	"count" : 0,
	"image" : "res://assets/boosters/Sedot.png",
	"value" : 50,
}
@export var booster_heart : Dictionary = {
	"count" : 0,
	"image" : "res://assets/boosters/Heart to heart.png",
	"value" : 50,
}

@export var last_lobby : String

@export var inventory_cats : Dictionary = {
	0 : {
		"count": 0, 
		"image": "res://assets/Kepala/Tak berjudul324_20251212163405.png",
		"cat_scene" : "res://extra assets/cats/cat_0.tscn",
	},
	1 : {
		"count": 0, 
		"image": "res://assets/Kepala/Tak berjudul324_20251212163414.png",
		"cat_scene" : "res://extra assets/cats/cat_1.tscn",
	},
	2 : {
		"count": 0, 
		"image": "res://assets/Kepala/Tak berjudul324_20251212163423.png",
		"cat_scene" : "res://extra assets/cats/cat_2.tscn",
	},
	3 : {
		"count": 0, 
		"image": "res://assets/Kepala/Tak berjudul324_20251212163428.png",
		"cat_scene" : "res://extra assets/cats/cat_3.tscn",

	},
	4 : {
		"count": 0, 
		"image": "res://assets/Kepala/Tak berjudul324_20251212163434.png",
		"cat_scene" : "res://extra assets/cats/cat_4.tscn",
	},
	5 : {
		"count": 0, 
		"image": "res://assets/Kepala/Tak berjudul324_20251212163438.png",
		"cat_scene" : "res://extra assets/cats/cat_5.tscn",
	},
	6 : {
		"count": 0, 
		"image": "res://assets/Kepala/Tak berjudul324_20251212163442.png",
		"cat_scene" : "res://extra assets/cats/cat_6.tscn",
	7 : {
		"count": 0,
		"image": "res://assets/Kepala/Tak berjudul324_20251212163445.png",
		"cat_scene" : "res://extra assets/cats/cat_7.tscn",
		}
	},
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
	9 : {
		"count" : 0,
		"image": "res://assets/furniture tall/bunga.png",
		"furniture_scene" : "res://extra assets/Furnitures/furniture_10.tscn",
		"value" : 150
	}
}
#array because i dont know how to handle new instances of rooms with unique names (or not) in a dictionary
@export var rooms : Array = [
	[[],
	
	[ {
	0 : {
		"count": 0, 
		"image": "res://icon.svg",
		"cat_scene" : "res://extra assets/cats/cat_0.tscn",
	},
	1 : {
		"count": 0, 
		"image": "res://icon.svg",
		"cat_scene" : "res://extra assets/cats/cat_1.tscn",
	},
	2 : {
		"count": 2, 
		"image": "res://icon.svg",
		"cat_scene" : "res://extra assets/cats/cat_2.tscn",
	},
	3 : {
		"count": 3, 
		"image": "res://icon.svg",
		"cat_scene" : "res://extra assets/cats/cat_3.tscn",
	},
	4 : {
		"count": 0, 
		"image": "res://icon.svg",
		"cat_scene" : "res://extra assets/cats/cat_4.tscn",
	},
	5 : {
		"count": 0, 
		"image": "res://icon.svg",
		"cat_scene" : "res://extra assets/cats/cat_5.tscn",
	},
	6 : {
		"count": 0, 
		"image": "res://icon.svg",
		"cat_scene" : "res://extra assets/cats/cat_6.tscn",
	},
	} ],
	{"model": 0}
	]
]  

@export var stages : Dictionary = {
	0 : {"stars": 0.0 , "first_clear": false},
	1 : {"stars": 0.0 , "first_clear": false},
	2 : {"stars": 0.0 , "first_clear": false},
	3 : {"stars": 0.0 , "first_clear": false},
	4 : {"stars": 0.0 , "first_clear": false},
	5 : {"stars": 0.0 , "first_clear": false},
	6 : {"stars": 0.0 , "first_clear": false},
	7 : {"stars": 0.0 , "first_clear": false},
	8 : {"stars": 0.0 , "first_clear": false},
	9 : {"stars": 0.0 , "first_clear": false},
	10 : {"stars": 0.0 , "first_clear": false},
	11 : {"stars": 0.0 , "first_clear": false},
	12 : {"stars": 0.0 , "first_clear": false},
	13 : {"stars": 0.0 , "first_clear": false},
	14 : {"stars": 0.0 , "first_clear": false},
	15 : {"stars": 0.0 , "first_clear": false},
	16 : {"stars": 0.0 , "first_clear": false},
	17 : {"stars": 0.0 , "first_clear": false},
	18 : {"stars": 0.0 , "first_clear": false},
	19 : {"stars": 0.0 , "first_clear": false},
	20 : {"stars": 0.0 , "first_clear": false},
	21 : {"stars": 0.0 , "first_clear": false},
	22 : {"stars": 0.0 , "first_clear": false},
	23 : {"stars": 0.0 , "first_clear": false},
	24 : {"stars": 0.0 , "first_clear": false},
	25 : {"stars": 0.0 , "first_clear": false}
}

func save_data():
	var file = FileAccess.open("user://file1.save", FileAccess.WRITE)
	file.store_var(stages)
	file.store_var(rooms)
	file.store_var(money_1)
	file.store_var(money_2)
	file.store_var(inventory_furniture)
	file.store_var(inventory_cats)
	file.store_var(booster_magnet)
	file.store_var(booster_invincible)
	file.store_var(booster_heart)
	file.store_var(first_times)

func load_data():
	if FileAccess.file_exists("user://file1.save"):
		var file = FileAccess.open("user://file1.save", FileAccess.READ)
		stages = file.get_var()
		rooms = file.get_var()
		money_1 = file.get_var()
		money_2 = file.get_var()
		inventory_furniture = file.get_var()
		inventory_cats = file.get_var()
		booster_magnet = file.get_var()
		booster_invincible = file.get_var()
		booster_heart = file.get_var()
		first_times = file.get_var()

	else:
		print("no save here")
# array format -> cats = [<cat type>, <location>]   |     furniture in inventory = [<furniture>, <amount>]
