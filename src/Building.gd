extends StaticBody2D

var building_type_dic = {"under_construction":"res://Textures/blue_button07.png","barracks":"res://Textures/Brothel.png","house":"res://Textures/House.png","town_center":"res://Textures/Library.png","mill":"res://Textures/Mill.png","workshop":"res://Textures/Construction.png"}
var building_type
onready var sprite = $Sprite
var selected = false
var placed
var done_built
var max_health
var health
var building_cost
var progress_bar
signal get_resource

func get_collision_shape():
	return $Collision_Shape.shape

func build(kind):
	if kind == "house":
		max_health = 200
		building_cost = 200
	if kind == "workshop":
		max_health = 600
		building_cost = 600
	if kind == "mill":
		max_health = 100
		building_cost = 200
	if kind == "town_center":
		max_health = 700
		building_cost = 700
	if kind == "barracks":
		max_health = 300
		building_cost = 400
	sprite.set_texture(load(building_type_dic[kind]))
	building_type = kind

func store_location():
	get_parent().GUI.selected_entity_location = get_global_position()

func gui_show():
	get_parent().GUI.close()
	if not done_built:
		return
	if building_type == "house":
		get_parent().GUI.show_house()
	if building_type == "town_center":
		get_parent().GUI.show_town_center()
	if building_type == "barracks":
		get_parent().GUI.show_barracks()
	if building_type == "workshop":
		get_parent().GUI.show_workshop()
		
func _unselect():
	selected = false
	
func _select():
	selected = true


func _ready():
	$Timer.start()
	health = 0
	sprite.set_region(false)
	set_collision_mask(0)
	set_collision_layer(0)
	$Clickable.set_collision_layer(0)
	placed = false
	set_process(false)
	yield(get_tree().create_timer(0.01), "timeout")
	set_process(true)
	yield(get_tree().create_timer(0.01), "timeout")
	visible = true
	
	
func _process(delta):
	if health < 0:
		queue_free()
	if not placed:
		var m_pos = get_global_mouse_position()
		set_position(m_pos)
		if Input.is_action_just_released("esc"):
			get_parent().HUD.lumber += building_cost
			queue_free()
		if Input.is_action_just_released("left_click"):
			sprite.set_texture(load(building_type_dic["under_construction"]))
			sprite.set_region(true)
			$Clickable.set_collision_layer(1)
			set_collision_mask(2)
			set_collision_layer(2)
			get_parent().just_Built(global_position)
			yield(get_tree().create_timer(0.03), "timeout")
			placed = true
			progress_bar = load("res://Assets/ProgressBar.tscn").instance()
			add_child(progress_bar)
	if placed and not done_built:
		progress_bar.set_value((health * 100)/max_health)
		if health >= max_health:
			sprite.set_region(false)
			sprite.set_texture(load(building_type_dic[building_type]))
			done_built = true
			progress_bar.free()
			if building_type == "workshop":
				$Clickable.set_collision_layer(1)
				set_collision_layer(0)
	if placed and done_built:
		pass
		
		





func _on_Timer_timeout():
	if done_built and building_type == "house":
		get_parent().HUD.gold += 20
	pass # Replace with function body.
