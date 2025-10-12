extends Node2D

@export var money_1 : int = 0
@export var money_2 : int = 0
@export var level_progress : int = 0

@export var booster_magnet : int = 0
@export var booster_invincible : int = 0
@export var booster_heart : int = 0

@export var last_lobby : String

@export var ownership_cats : Array = [
	{"cat_1":0},
	{"cat_2":0},
	{"cat_3":0},
]
@export var ownership_furniture : Array = [ #change to nested dictionary
	{"furn_1":0},
	{"furn_2":0},
	{"furn_3":0},
]

# array format -> cats = [<cat type>, <location>]   |     furniture in inventory = [<furniture>, <amount>]
