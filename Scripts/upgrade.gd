extends Button

#Upgrades and their description temp location, 10 upgrades at least
var dict_of_upgrades = {
	"Passives":{
		"Opponent +1 Win Square":"",
		"Occasional Hint at opponent selection":""
	},
	"RPS":{
		#thought here is that you could spend an upgrade to change one 
		#of your options? 
		#Scissors -> Shears -> Chainsaw
		#Rock -> Boulder -> Concrete
		#Paper -> Paper Mache -> Forest
		"Rock":["Boulder", "Concrete"],
		"Paper":["Paper Mache", "Forest"],
		"Scissors":["Shears","Chainsaw"],
	},
	"Active":{
		"Double or Nothing":"",
		"Disable one Option":""
	}
}

var chosen_self = ""

func who_am_i():
	var topleveltypes = ["RPS", "Active", "Passive"]
	#var topleveltype = topleveltypes[randi()%topleveltypes.size()]
	var topleveltype = "RPS"
	var possible_self = []
	
	if topleveltype == "RPS":
		var RPS_levels_list = get_tree().get_first_node_in_group("GM")._check_levels()
		for node_level in RPS_levels_list:
			possible_self.append(dict_of_upgrades["RPS"][node_level[0]][node_level[1]])
		return possible_self[randi()%possible_self.size()]
		
		
func _ready() -> void:
	self.name = who_am_i()
	self.text = self.name
	print(self.name)
	
