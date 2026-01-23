extends HBoxContainer
var selected = ""
var list_of_available_RPS = []
@export var is_player = true


func _ready() -> void:
	var GameMaster = get_tree().get_first_node_in_group("GM")
	var rock_instance = GameMaster.RockComponent.instantiate()
	var paper_instance = GameMaster.PaperComponent.instantiate()
	var scissors_instance = GameMaster.ScissorsComponent.instantiate()
	var empty_style = StyleBoxEmpty.new()
	
	add_child(rock_instance)
	add_child(paper_instance)
	add_child(scissors_instance)
	
	#List for easy access to components for upgrades/changes, each binded
	for child in get_children():
		list_of_available_RPS.append(child)
		if is_player:
			list_of_available_RPS.back().pressed.connect(_PLAYER_select.bind(child))
		else:
			list_of_available_RPS.back().disabled = true
			list_of_available_RPS.back().players_RPS = false
			list_of_available_RPS.back().add_theme_stylebox_override("focus", empty_style)



func _choose_option():
	if !is_player:
		selected = list_of_available_RPS[randi() % list_of_available_RPS.size()].name


func _clear_selected():
	selected = ""


func _PLAYER_select(child):
	selected = child.name 
