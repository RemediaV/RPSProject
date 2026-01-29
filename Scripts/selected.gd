extends RichTextLabel


func _ready() -> void:
	text = "Selected: "

func update_self(selected):
	text = "Selected: " + str(selected)
	
func win_feedback(tie = false, winner = "", winning_rps = "", loser = "", losing_rps = ""):
	if !tie:
		text = winner + "'s " + winning_rps + " beats " + loser + "'s " + losing_rps
	else:
		text = "Tied!"


func _on_timer_timeout() -> void:
	if !text.contains("Selected: "):
		text = "Selected: "
