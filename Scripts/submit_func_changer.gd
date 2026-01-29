extends Button


@export var state = 0

func _ready() -> void:
	gm.select_binder()

func state_change(statenum):
	if statenum == 1:
		state = 1
		self.text = "Play Again?"
	elif statenum == 2:
		state = 2
		self.text = "Next Round"
	elif statenum == 0:
		state = 0
		self.text = "Submit"
