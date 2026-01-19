extends HBoxContainer


func _a_win_occurs(winner_string):
	var last_win_check = 0
	if winner_string == self.name:
		for child in get_children():
			if child is ColorRect:
				if child.color == Color("#3a0100"):
					if last_win_check == 0:
						child.color = Color.CHARTREUSE
					last_win_check += 1
	if last_win_check >= 2:
		return
	if last_win_check == 1:
		print("Next Round!")
		get_tree().call_group("GM","_display_upgrades")
					
