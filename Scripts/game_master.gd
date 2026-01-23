extends Node

#All component preload
var RockComponent = preload("res://Scenes/RPSCompnents/rockcomponent.tscn")
var PaperComponent = preload("res://Scenes/RPSCompnents/papercomponent.tscn")
var ScissorsComponent = preload("res://Scenes/RPSCompnents/scissorscomponent.tscn")
var p1_submitted
var cpu_submitted
#var winner


var RPS_dictionary: Dictionary = {
	"Rock": ["Scissors"],
	"Scissors": ["Paper"],
	"Paper": ["Rock"],
	"": [""] 
	}

func _ready() -> void:
	%Submit.pressed.connect(_on_submit_pressed.bind())
	
func _on_submit_pressed(timer_bool: bool = false):
	get_tree().call_group("All_Nodes_Caller", "_choose_option")
	calculate_RPS_submissions(timer_bool)
	get_tree().call_group("All_Nodes_Caller", "_clear_selected")
	
func calculate_RPS_submissions(timer: bool = false):
	var All_Nodes_Caller_nodes = get_tree().get_nodes_in_group("All_Nodes_Caller")
	for node in All_Nodes_Caller_nodes:
		if node.get("is_player") != null:
			if node.selected == "" and !timer:
				print("Need to select an option.")
				return
			elif node.is_player:
				p1_submitted = node.selected
			else:
				cpu_submitted = node.selected
	print("Player: " + p1_submitted)
	print("CPU: " + cpu_submitted)
	#replace with functions that display tie, win or loss anim.	
	if p1_submitted == cpu_submitted:
		#tie logic
		print("--Tie, No Wins")
		get_tree().call_group("All_Nodes_Caller","_timer_reset")
		return 
	elif cpu_submitted in RPS_dictionary[p1_submitted]:
		#Player WIN logic
		player_wins()
		return 
	else:
		#CPU WIN logic
		cpu_wins()
		return 

func _timer_complete():
	print("Times Up!")
	_on_submit_pressed(true)
	get_tree().call_group("All_Nodes_Caller","_timer_reset")
	
func _display_upgrades():
	get_tree().call_group("All_Nodes_Caller","_timer_reset")
	get_tree().call_group("All_Nodes_Caller","_timer_stop")
	%UpgradeHover.visible = true

func cpu_wins():
	print("--Cpu Wins")
	get_tree().call_group("All_Nodes_Caller","_a_win_occurs","CPUWins")
	get_tree().call_group("All_Nodes_Caller","_timer_reset")
	
func player_wins():
	print("--Player Wins")
	get_tree().call_group("All_Nodes_Caller","_a_win_occurs","PlayerWins")
	get_tree().call_group("All_Nodes_Caller","_timer_reset")

func _check_levels():
	var All_Nodes_Caller_nodes = get_tree().get_nodes_in_group("All_Nodes_Caller")
	var node_list_with_levels = []
	for node in All_Nodes_Caller_nodes:
		if node.get("players_RPS") != null:
			if node.get("my_level") != null and node.players_RPS == true:
				node_list_with_levels.append([node.name,node.my_level])
	print(node_list_with_levels)
	return node_list_with_levels


func _GameOver():
	get_tree().call_group("All_Nodes_Caller","_timer_stop")
	%Submit.disabled = true
