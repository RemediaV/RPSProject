extends ProgressBar
@export var value_subtract = .20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	value -= value_subtract
	if value <= 0:
		get_tree().call_group("GM","_timer_complete")
		
		
		
func _timer_reset():
	value = max_value
	
func _timer_stop():
	value_subtract = 0

func _timer_start():
	value_subtract =.20
	
