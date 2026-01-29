extends Button

var players_RPS = true
@export var my_level = 0

func inc_level(new_name):
	my_level += 1
	text = new_name
