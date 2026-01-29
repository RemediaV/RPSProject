extends HBoxContainer

var Upgrade_Packed = load("res://Scenes/upgrade_1.tscn")

func _ready() -> void:
	randomize()
	var up1 = Upgrade_Packed.instantiate()
	var up2 = Upgrade_Packed.instantiate()
	var up3 = Upgrade_Packed.instantiate()
	add_child(up1)
	add_child(up2)
	add_child(up3)
	
