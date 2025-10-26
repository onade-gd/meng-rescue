extends Node2D

@export var money_1 : int = 0
@export var money_2 : int = 0
@export var level_progress : int = 0

@export var booster_magnet : int = 0
@export var booster_invincible : int = 0
@export var booster_heart : int = 0

@export var last_lobby : String

@export var inventory_cats : Dictionary = {  #needs work
	"cat_1" : 0,
	"cat_2" : 0,
	"cat_3" : 0
}

@export var inventory_furniture : Dictionary = {
	"furn_1" : 0,
	"furn_2" : 0,
	"furn_3" : 0
}

@export var rooms : Array = [    #array because i dont know how to handle new instances of rooms with unique names (or not) in a dictionary
	[                                                                           #\
		{"furn_1":{"pos": Vector2(0,0)}},                                       # |
		{"furn_5":{"pos": Vector2(0,0)}},                                       # | - room 0 and its contents, can add more furnitures/cats into the array
		{"furn_2":{"pos": Vector2(0,0)}},                                       # |
		{"cat_4" :{"pos": Vector2(randf_range(30,1410),randf_range(30,2070))}}  # |
	],                                                                          #/
	[                                           #\
		{"furn_2":{"pos": Vector2(0,0)}},       # | - room 1 and its contents, etc
		{"furn_4":{"pos": Vector2(0,0)}}        # |
	],                                          #/
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

# array format -> cats = [<cat type>, <location>]   |     furniture in inventory = [<furniture>, <amount>]
