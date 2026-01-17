extends MarginContainer

var selected: Object = null
@onready var list_of_available_RPS = []

func _ready() -> void:
	randomize()
	var gm = %GameMaster
	
	var rock_instance = gm.RockComponent.instantiate()
	var paper_instance = gm.PaperComponent.instantiate()
	var scissors_instance = gm.ScissorsComponent.instantiate()
	
	gm.connect("player_submitted", _on_GM_request)
	
	get_child(0).add_child(rock_instance)
	get_child(0).add_child(paper_instance)
	get_child(0).add_child(scissors_instance)
	
	for child in get_child(0).get_children():
		list_of_available_RPS.append(child)
		list_of_available_RPS.back().disabled = true
		
		
func _on_GM_request():
	selected = list_of_available_RPS[randi() % list_of_available_RPS.size()]
	print(selected)
	
