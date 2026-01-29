extends HBoxContainer


func _a_win_occurs(winner_string):
	#this resets 0 every run
	var last_win_check = 0
	# if you are winner...
	if winner_string == self.name:
		#check your children.
		for child in get_children():
			#if they are color rectangle...
			if child is ColorRect:
				#..and red...
				if child.color == Color("#3a0100"):
					#..and this is the first red found...
					if last_win_check == 0:
						#change one to green.
						child.color = Color.CHARTREUSE
					#this increments if color is red
					last_win_check += 1
	#if there are still red children left
	if last_win_check >= 2:
		return
	#this happens only if the last red child has been turned green
	if last_win_check == 1:
		if self.name == "CPUWins":
			print("Game Over!")
			gm._GameOver()
			return
		print("Next Round!")
		gm._display_upgrades()
		
func _win_reset():
	for child in get_children():
		if child is ColorRect:
			child.color = Color("#3a0100")
