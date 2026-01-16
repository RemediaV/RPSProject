extends MarginContainer

var selected: Object = null

func _ready() -> void:
	var gm = %GameMaster
	
	var rock_instance = gm.RockComponent.instantiate()
	var paper_instance = gm.PaperComponent.instantiate()
	var scissors_instance = gm.ScissorsComponent.instantiate()
	
	var list_of_available_RPS = []
	
	
	get_child(0).add_child(rock_instance)
	get_child(0).add_child(paper_instance)
	get_child(0).add_child(scissors_instance)
	
	#List for easy access to components for upgrades/changes
	for child in get_child(0).get_children():
		list_of_available_RPS.append(child)
		list_of_available_RPS.back().pressed.connect(_on_RPS_select.bind(child))
	

	
	
func _on_RPS_select(childObj):
	selected = childObj

	
