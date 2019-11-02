extends Control

onready var game = get_parent().get_parent()
onready var itemList = $MarginContainer/ItemList
var selected_entity_location

func _ready():
	visible = false

func close():
	for child in itemList.get_children():
		child.queue_free()

func show_civilian():
	visible = true
	var house_button = preload("res://Assets/Command_Button.tscn").instance()
	house_button.new("house")
	itemList.add_child(house_button)
	var mill_button = preload("res://Assets/Command_Button.tscn").instance()
	mill_button.new("mill")
	itemList.add_child(mill_button)
	var barracks_button = preload("res://Assets/Command_Button.tscn").instance()
	barracks_button.new("barracks")
	itemList.add_child(barracks_button)
	var ws_button = preload("res://Assets/Command_Button.tscn").instance()
	ws_button.new("workshop")
	itemList.add_child(ws_button)
	var house_butto = preload("res://Assets/Command_Button.tscn").instance()
	house_butto.new("town_center")
	itemList.add_child(house_butto)
	
	
func show_explorer():
	visible = true
	var house_button = preload("res://Assets/Command_Button.tscn").instance()
	house_button.new("town_center")
	itemList.add_child(house_button)
	var hous_button = preload("res://Assets/Command_Button.tscn").instance()
	hous_button.new("house")
	itemList.add_child(hous_button)
	

func show_rogue():
	pass

func show_knight():
	pass
	
	
func show_house():
	visible = true
	#house stuff
	
func show_workshop():
	#tools
	var hammer = preload("res://Assets/Command_Button.tscn").instance()
	hammer.new("hammer")
	itemList.add_child(hammer)
	var swd = preload("res://Assets/Command_Button.tscn").instance()
	swd.new("basic_sword")
	itemList.add_child(swd)
	
	var house_button = preload("res://Assets/Command_Button.tscn").instance()
	house_button.new("rogue")
	itemList.add_child(house_button)
	
	
	
func show_barracks():
	visible = true
	var house_button = preload("res://Assets/Command_Button.tscn").instance()
	house_button.new("knight")
	itemList.add_child(house_button)
	
func show_town_center():
	visible = true
	var house_button = preload("res://Assets/Command_Button.tscn").instance()
	house_button.new("civilian")
	itemList.add_child(house_button)