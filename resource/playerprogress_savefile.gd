extends Node2D

@export var money : int = 0
@export var level_progress : int = 0
@export var last_lobby : String

@export var ownership_cats : Array
@export var ownership_furniture : Array

# array format -> cats = [<cat type>, <location>]   |     furniture in inventory = [<furniture>, <amount>
