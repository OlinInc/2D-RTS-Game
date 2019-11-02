extends Button

onready var GUI = get_parent().get_parent().get_parent()
var icons = {"house":"res://Textures/House.png","town_center":"res://Textures/Library.png","mill":"res://Textures/Mill.png","barracks":"res://Textures/Brothel.png","workshop":"res://Textures/Workshop.png"}
var current_icon


func new(type):
	if type in icons:
		set_button_icon(load(icons[type]))
	else:
		if type == "civilian":
			set_text(type)
		if type == "knight":
			set_text(type)
		if type == "rogue":
			set_text(type)
		if type == "explorer":
			set_text(type)
		if type == "hammer":
			set_text("forge hammer")
		if type == "basic_sword":
			set_text("forge sword")
	current_icon = type

func _on_Button_pressed():
	if current_icon == "house":
		if not GUI.game.spawn_Building("house"):
			print("Not Enough Gold!")
	if current_icon == "mill":
		if not GUI.game.spawn_Building("mill"):
			print("Not Enough Gold!")
	if current_icon == "town_center":
		if not GUI.game.spawn_Building("town_center"):
			print("Not Enough Gold!")
	if current_icon == "barracks":
		if not GUI.game.spawn_Building("barracks"):
			print("Not Enough Gold!")
	if current_icon == "workshop":
		if not GUI.game.spawn_Building("workshop"):
			print("Not Enough Gold!")
		
	if current_icon == "civilian":
		if not GUI.game.spawn_Unit("civilian", GUI.selected_entity_location):
			print("Not Enough Gold!")
	if current_icon == "knight":
		if not GUI.game.spawn_Unit("knight", GUI.selected_entity_location):
			print("Not Enough Gold!")
	if current_icon == "rogue":
		if not GUI.game.spawn_Unit("rogue", GUI.selected_entity_location):
			print("Not Enough Gold!")
			
	if current_icon == "hammer":
		if not GUI.game.forge("hammer", GUI.selected_entity_location, false):
			print("Not Enough Gold!")
	if current_icon == "basic_sword":
		if not GUI.game.forge("basic_sword", GUI.selected_entity_location, false):
			print("Not Enough Gold!")