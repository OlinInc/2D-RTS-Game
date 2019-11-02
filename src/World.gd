extends Node2D
#extends res://src/Sprite.gd
onready var HUD = $HUD
onready var GUI = $HUD/Entity_GUI
signal unselect
var selected

func spawn_Building(kind): #returns true on success
	if kind == "town_center":
		if HUD.lumber >= 500:
			HUD.lumber -= 500
		else:
			return false
	if kind == "mill":
		if HUD.lumber >= 200:
			HUD.lumber -= 200
		else:
			return false
	if kind == "house":
		if HUD.lumber >= 200:
			HUD.lumber -= 200
		else:
			return false
	if kind == "barracks":
		if HUD.lumber >= 400:
			HUD.lumber -= 400
		else:
			return false
	if kind == "workshop":
		if HUD.lumber >= 600:
			HUD.lumber -= 600
		else:
			return false
	var building = load("res://Assets/Building.tscn").instance()
	building.visible = false
	self.add_child(building)
	building.build(kind)
	yield(get_tree().create_timer(0.03), "timeout")
	
	return true


func just_Built(just_built_location):
	selected.target_global_position = just_built_location
	selected.set_physics_process(true)

func spawn_Unit(kind,loc) -> Object:
	if kind == "civilian":
		if HUD.gold >= 100:
			HUD.gold -= 100
		else:
			return null
	if kind == "rogue":
		if HUD.gold >= 80:
			HUD.gold -= 80
		else:
			return null
	if kind == "knight":
		if HUD.metal >= 50 and HUD.gold >= 50:
			HUD.metal -= 50
			HUD.gold -= 50
		else:
			return null
	if kind == "explorer":
		if HUD.gold >= 100:
			HUD.gold -= 100
		else:
			return null
	var unit = load("res://Assets/Unit.tscn").instance()
	var spawn_position_as_Vector2D = loc
	self.add_child(unit)
	unit.spawn(kind,spawn_position_as_Vector2D)
	return unit

func forge(kind,loc,built):
	var new_tool = load("res://Assets/Tool.tscn").instance()
	self.add_child(new_tool)
	new_tool.init(kind,loc,built)


func _ready():
	selected = spawn_Unit("civilian", Vector2(150,150))
	spawn_Unit("explorer", Vector2(100,100))
	var first_tool = load("res://Assets/Tool.tscn").instance()
	add_child(first_tool)
	first_tool.init("basic_sword",Vector2(200,200),true)
	