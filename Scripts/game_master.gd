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
	"Boulder": ["Rock", "Paper", "Scissors", "Shears"],
	"Shears": ["Rock", "Paper", "Scissors", "Paper Mache"],
	"Paper Mache": ["Rock", "Paper", "Scissors", "Boulder"],
	"": [""] 
	}

func select_binder() -> void:
	node_finder("Submit").pressed.connect(_on_submit_pressed.bind())
	
	
func _on_submit_pressed(timer_bool: bool = false):
	var submit_button = node_finder("Submit")
	var upgrade_screen = node_finder("UpgradeHover")
	if submit_button.state == 0:
		get_tree().call_group("All_Nodes_Caller", "_choose_option")
		calculate_RPS_submissions(timer_bool)
		get_tree().call_group("All_Nodes_Caller", "_clear_selected")
	#game over
	elif submit_button.state == 1:
		get_tree().reload_current_scene()
	#next round
	elif submit_button.state == 2:
		upgrade_screen.visible = !upgrade_screen.visible
		submit_button.state_change(0)
		get_tree().call_group("All_Nodes_Caller","_timer_start")
		get_tree().call_group("All_Nodes_Caller","_win_reset")
	
func calculate_RPS_submissions(timer: bool = false):
	var players_RPS_logic = node_finder("RPSLogic","is_player", true)
	var CPUs_RPS_logic = node_finder("RPSLogic","is_player", false)
	#var All_Nodes_Caller_nodes = get_tree().get_nodes_in_group("All_Nodes_Caller")
	#for node in All_Nodes_Caller_nodes:
		#if node.get("is_player") != null:
	if players_RPS_logic.selected == "" and !timer:
		print("Need to select an option.")
		return
	p1_submitted = players_RPS_logic.selected
	cpu_submitted = CPUs_RPS_logic.selected
	print("Player: " + p1_submitted)
	print("CPU: " + cpu_submitted)
	#replace with functions that display tie, win or loss anim.	
	if p1_submitted == cpu_submitted:
		#tie logic
		var selected_txt = node_finder("Selected")
		print("--Tie, No Wins")
		get_tree().call_group("All_Nodes_Caller","_timer_reset")
		selected_txt.win_feedback(true)
		return 
	elif cpu_submitted in RPS_dictionary[p1_submitted]:
		#Player WIN logic
		player_wins(p1_submitted, cpu_submitted)
		return 
	else:
		#CPU WIN logic
		cpu_wins(p1_submitted, cpu_submitted)
		return 

func _timer_complete():
	print("Times Up!")
	_on_submit_pressed(true)
	get_tree().call_group("All_Nodes_Caller","_timer_reset")
	
	
func _display_upgrades():
	var submit_button = node_finder("Submit")
	var upgrade_screen = node_finder("UpgradeHover")
	get_tree().call_group("All_Nodes_Caller","_timer_reset")
	get_tree().call_group("All_Nodes_Caller","_timer_stop")
	submit_button.state_change(2)
	upgrade_screen.visible = true
	

func selected_update(selected):
	node_finder("Selected").update_self(selected)

func cpu_wins(p1,cpu):
	var selected_txt = node_finder("Selected")
	print("--Cpu Wins")
	get_tree().call_group("All_Nodes_Caller","_a_win_occurs","CPUWins")
	get_tree().call_group("All_Nodes_Caller","_timer_reset")
	selected_txt.win_feedback(false,"CPU",cpu,"Player",p1)
	
func player_wins(p1, cpu):
	var selected_txt = node_finder("Selected")
	print("--Player Wins")
	get_tree().call_group("All_Nodes_Caller","_a_win_occurs","PlayerWins")
	get_tree().call_group("All_Nodes_Caller","_timer_reset")
	selected_txt.win_feedback(false,"Player",p1,"CPU",cpu)

func _check_levels():
	var node_list_with_levels = []
	var players_RPS_component = node_finder("","players_RPS",true,true)
	for itera in players_RPS_component:
		node_list_with_levels.append([itera.name,itera.my_level])
	return node_list_with_levels

func option_chosen(selfname: String):
	if selfname.contains("Boulder"):
		node_finder("Rock","players_RPS",true).inc_level("Boulder")
	if selfname.contains("Shears"):
		node_finder("Scissors","players_RPS",true).inc_level("Shears")
	if selfname.contains("Paper Mache"):
		node_finder("Paper","players_RPS",true).inc_level("Paper Mache")
	if selfname.contains("Concrete"):
		node_finder("Rock","players_RPS",true).inc_level("Concrete")
	if selfname.contains("Chainsaw"):
		node_finder("Scissors","players_RPS",true).inc_level("Chainsaw")
	if selfname.contains("Forest"):
		node_finder("Paper","players_RPS",true).inc_level("Forest")

func _GameOver():
	var submit_button = node_finder("Submit")
	submit_button.state_change(1)
	get_tree().call_group("All_Nodes_Caller","_timer_stop")
	
func node_finder(node_to_find: String = "", variable_to_check: String = "", variable_expected_value: Variant = "", listed: bool = false):
	var listed_var = []
	if node_to_find != "":
		for node in get_tree().get_nodes_in_group("All_Nodes_Caller"):
			if node.name == node_to_find:
				if variable_to_check == "":
					if !listed:
						return node
					else:
						listed_var.append(node)
				elif node.get(variable_to_check) == variable_expected_value:
					if !listed:
						return node
					else:
						listed_var.append(node)
	for node in get_tree().get_nodes_in_group("All_Nodes_Caller"):
		if node.get(variable_to_check) == variable_expected_value:
			if !listed:
				return node
			else:
				listed_var.append(node)
	return listed_var
		
