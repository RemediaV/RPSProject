extends Button
var up_definitions = {
	
}
#Upgrades and their description temp location, 10 upgrades at least
var dict_of_upgrades = {
	"Passive":{
		0 :"Opponent +1 Win Square",
		1: "Occasional Hint at opponent selection"
	},
	"RPS":{
		#thought here is that you could spend an upgrade to change one 
		#of your options? 
		#Scissors -> Shears -> Chainsaw
		#Rock -> Boulder -> Concrete
		#Paper -> Paper Mache -> Forest
		"Rock":["Boulder", "Concrete"],
		"Paper":["Paper Mache", "Forest"],
		"Scissors":["Shears","Chainsaw"]
	},
	"Active":{
		0: "Double or Nothing",
		1: "Disable one Option"
	}
}

var chosen_self = ""

func who_am_i():
	var topleveltypes = ["RPS", "Active", "Passive"]
	var topleveltype = topleveltypes[randi()%topleveltypes.size()]
	#var topleveltype = "RPS"
	
	randomize()
	if topleveltype == "RPS":
		var possible_self = []
		var RPS_levels_list = gm._check_levels()
		for node0_level1 in RPS_levels_list:
			possible_self.append(dict_of_upgrades["RPS"][node0_level1[0]][node0_level1[1]])
		return possible_self[randi()%possible_self.size()]
	elif topleveltype == "Active": 
		return dict_of_upgrades["Active"][randi()%dict_of_upgrades["Active"].size()]
	else:
		return dict_of_upgrades["Passive"][randi()%dict_of_upgrades["Passive"].size()]
	



func _ready() -> void:
	self.name = who_am_i()
	self.text = self.name
	


func _on_pressed() -> void:
	gm.option_chosen(self.name)
