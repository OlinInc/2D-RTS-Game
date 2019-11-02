extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var gold_label = $Resource_Values/MarginContainer/HBoxContainer/VBoxContainer2/gold_label
onready var metal_label = $Resource_Values/MarginContainer/HBoxContainer/VBoxContainer2/metal_label
onready var lumber_label = $Resource_Values/MarginContainer/HBoxContainer/VBoxContainer2/lumber_label
onready var game_time_label = $Resource_Values/Game_Timer
onready var game_timer = $Resource_Values/Game_Timer/Timer
var gold
var metal
var lumber

func _ready():
	game_timer.start()
	gold = 300
	metal = 0
	lumber = 1000
	pass # Replace with function body.


func _process(delta):
	gold_label.set_text(String(floor(gold)))
	metal_label.set_text(String(floor(metal)))
	lumber_label.set_text(String(floor(lumber)))
	game_time_label.set_text(String(720 - game_timer.get_time_left()))
