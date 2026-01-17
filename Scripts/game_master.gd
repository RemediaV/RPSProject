extends Node
signal player_submitted
#All component preload
var RockComponent = preload("res://Scenes/RPSCompnents/rockcomponent.tscn")
var PaperComponent = preload("res://Scenes/RPSCompnents/papercomponent.tscn")
var ScissorsComponent = preload("res://Scenes/RPSCompnents/scissorscomponent.tscn")
var p1_submitted: Object = null
var cpu_submitted: Object = null

@onready var cpu = %CPU
@onready var p1 = %Player
func _ready() -> void:
	%Submit.pressed.connect(_on_submit_pressed.bind(p1))
	
	
func _on_submit_pressed(p1obj: Object):
	p1_submitted = p1obj.selected
	print("Player: " + str(p1_submitted))
	CPU_wake_up()

func CPU_wake_up():
	emit_signal("player_submitted")
	cpu_submitted = cpu.selected
	print("CPU: " + str(cpu_submitted))
