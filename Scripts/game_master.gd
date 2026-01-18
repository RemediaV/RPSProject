extends Node

#All component preload
var RockComponent = preload("res://Scenes/RPSCompnents/rockcomponent.tscn")
var PaperComponent = preload("res://Scenes/RPSCompnents/papercomponent.tscn")
var ScissorsComponent = preload("res://Scenes/RPSCompnents/scissorscomponent.tscn")
var p1_submitted
var cpu_submitted
var winner

var RPS_dictionary: Dictionary = {
	"Rock": ["Scissors"],
	"Scissors": ["Paper"],
	"Paper": ["Rock"]
	}




func _ready() -> void:
	%Submit.pressed.connect(_on_submit_pressed.bind())

	
func _on_submit_pressed():
	
	get_tree().call_group("All_Nodes_Caller", "_choose_option")

	calculate_RPS_submissions()
	get_tree().call_group("All_Nodes_Caller", "_clear_selected")
	
	
func calculate_RPS_submissions():
	var All_Nodes_Caller_nodes = get_tree().get_nodes_in_group("All_Nodes_Caller")
	for node in All_Nodes_Caller_nodes:
		if node.get("is_player") != null:
			if node.selected == "":
				print("Need to select an option.")
				return
			elif node.is_player:
				p1_submitted = node.selected
			else:
				cpu_submitted = node.selected
	print("Player: " + str(p1_submitted))
	print("CPU: " + str(cpu_submitted))
	#replace with functions that display tie, win or loss anim.	
	if p1_submitted == cpu_submitted:
		print("--Tie, No Wins")
		return 
	if cpu_submitted in RPS_dictionary[p1_submitted]:
		print("--Player Wins")
		return 
	else:
		print("--Cpu Wins")
		return 
