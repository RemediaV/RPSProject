extends CanvasLayer


var Upgrade_Screen_Packed = load("res://Scenes/UpgradeScene.tscn")




func _on_visibility_changed() -> void:
	if visible:
		var new_up_screen = Upgrade_Screen_Packed.instantiate()
		add_child(new_up_screen)
	else:
		get_child(0).queue_free()
