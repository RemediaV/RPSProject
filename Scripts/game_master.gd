extends Node

#All component preload
var RockComponent = preload("res://Scenes/RPSCompnents/rockcomponent.tscn")
var PaperComponent = preload("res://Scenes/RPSCompnents/papercomponent.tscn")
var ScissorsComponent = preload("res://Scenes/RPSCompnents/scissorscomponent.tscn")
var p1_submitted: Object = null

func _ready() -> void:
	var p1 = %Player
	%Submit.pressed.connect(_on_submit_pressed.bind(p1))
	
	
func _on_submit_pressed(p1: Object):
	p1_submitted = p1.selected
	print(p1_submitted)


	
