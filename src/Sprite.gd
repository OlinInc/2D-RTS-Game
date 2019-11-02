extends KinematicBody2D

var selected = false
onready var sprite = $Sprite
onready var label = $Label
const DIST_THRESHOLD = 8.0
var SLOW_RADIUS = 200.0
var max_speed = 300.0
var max_health = 100
var health = 100
var bp
var curr_tool 
var _velocity = Vector2.ZERO
var target_global_position = Vector2.ZERO
var unit_type_dic = {"civilian":Rect2(160,240,16,16),"knight":Rect2(128,240,16,16), "wizard":Rect2(144,224,16,16), "rogue":Rect2(176,224,16,16), "explorer":Rect2(112,224,16,16)}
var unit_type
var gather_pointer = null
var progress_bar

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func get_collision_shape():
	return $Collision_Shape.shape

# Called when the node enters the scene tree for the first time.
func _ready():
	label.visible = false
	set_physics_process(false)


func spawn(kind, loc):
	var new_region = unit_type_dic[kind]
	sprite.set_region_rect(new_region)
	unit_type = kind
	label.text = kind
	if kind == "civilian":
		max_speed = 100
		bp = 2
	if kind == "explorer":
		max_speed = 150
		SLOW_RADIUS = 200
		bp = .5 #for testing
	if kind == "knight":
		max_health = 400
		health = 400
		SLOW_RADIUS = 20
		max_speed = 80
		bp = .5
	if kind == "rogue":
		max_health = 300
		health = 300
		SLOW_RADIUS = 40
		max_speed = 120
		bp = .5
	set_global_position(Vector2(loc.x,loc.y+50))
	target_global_position = Vector2(loc.x,loc.y+100) #loc + spawning offset
	set_physics_process(true)
	

func _process(delta):
	if Input.is_action_just_released("right_click") and selected:
		target_global_position = get_global_mouse_position()
		set_physics_process(true)
	pass

func mine(rock):
	if global_position.distance_to(rock.get_ref().global_position) < SLOW_RADIUS/4:
		rock.get_ref().health -= .2*bp
		get_parent().HUD.metal += .2*bp

	else:
		gather_pointer = null
	if rock:
		$Timer.start()

	
func chop(tree):
	if global_position.distance_to(tree.get_ref().global_position) < SLOW_RADIUS/3:
		tree.get_ref().health -= .5*bp
		get_parent().HUD.lumber += .5*bp

	else:
		gather_pointer = null
	if tree:
		$Timer.start()

func build(build):
	if build.get_ref().health < build.get_ref().max_health:
		if global_position.distance_to(build.get_ref().global_position) < SLOW_RADIUS/2:
			
			build.get_ref().health += 30*bp
	else:
		gather_pointer = null
	if build:
		$Timer.start()

func forge(toolie):
	
	progress_bar.set_value((toolie.get_ref().forging))
	if toolie.get_ref().forging < 100:
		if global_position.distance_to(toolie.get_ref().global_position) < SLOW_RADIUS/2:
			toolie.get_ref().forging += 5*bp
			$Timer.start()
	else:
		progress_bar.free()
		gather_pointer = null
		return
	

	
	

func _on_Timer_timeout():
	if not gather_pointer:
		if curr_tool:
			curr_tool.animator.stop()
			curr_tool.sprite.rotation = 0
		return
	if not gather_pointer.get_ref():
		if curr_tool:
			curr_tool.animator.stop()
			curr_tool.sprite.rotation = 0
		return
	if "Rock" in gather_pointer.get_ref().name:
		mine(gather_pointer)
		return
	if "Tree" in gather_pointer.get_ref().name:
		chop(gather_pointer)
		return
	if "Build" in gather_pointer.get_ref().name:
		build(gather_pointer)
		return
	if "Tool" in gather_pointer.get_ref().name:
		forge(gather_pointer)
		return
	if progress_bar:
		progress_bar.free()

func _physics_process(delta):
	if(global_position.distance_to(target_global_position) < DIST_THRESHOLD):
		$Sprite/AnimationPlayer.stop()
		sprite.rotation = 0
		set_physics_process(false)
		return
	if global_position.distance_to(target_global_position) < SLOW_RADIUS/2: #PICKING UP
		
			var collisions = get_slide_count()
			for i in collisions:
				if get_slide_collision(i).collider:
					#print(String(get_angle_to(target_global_position) - get_angle_to(get_slide_collision(i).collider.get_global_position())))
					if target_global_position.distance_to(get_slide_collision(i).collider.get_global_position()) < 30:
						#print(get_slide_collision(i).collider.name)
						#print(global_position.distance_to(target_global_position), " AND ",SLOW_RADIUS/2)
						if "Tree" in get_slide_collision(i).collider.name:
							target_global_position = global_position
							var tree = weakref(get_slide_collision(i).collider)
							$Sprite/AnimationPlayer.stop()
							gather_pointer = tree
							sprite.rotation = 0
							if curr_tool:
								curr_tool.use(sprite.flip_h,bp)
							chop(tree)
							return
						if "Rock" in get_slide_collision(i).collider.name:
							target_global_position = global_position
							var rock = weakref(get_slide_collision(i).collider)
							$Sprite/AnimationPlayer.stop()
							gather_pointer = rock
							sprite.rotation = 0
							if curr_tool:
								curr_tool.use(sprite.flip_h,bp)
							mine(rock)
							return
						if "Building" in get_slide_collision(i).collider.name:
							target_global_position = global_position
							var building = weakref(get_slide_collision(i).collider)
							$Sprite/AnimationPlayer.stop()
							gather_pointer = building
							sprite.rotation = 0
							if curr_tool:
								curr_tool.use(sprite.flip_h,bp)
							build(building)
							return
						if "Tool" in get_slide_collision(i).collider.name:
							target_global_position = global_position
							var temp_tool = get_slide_collision(i).collider
							
							if temp_tool.built:
								print("picking up")
								pickUp(temp_tool)
								
								#gather_pointer = weakref(curr_tool)
							else:
								progress_bar = load("res://Assets/ProgressBar.tscn").instance()
								add_child(progress_bar)
								temp_tool = weakref(temp_tool)
								gather_pointer = temp_tool.get_ref()
								
								forge(temp_tool)
								
							return
			collisions = null
	$Sprite/AnimationPlayer.play("walking")
	gather_pointer = null
	if curr_tool:
		curr_tool.animator.playback_speed = 1
		curr_tool.animator.play("walking")
	sprite.flip_h = true if target_global_position.x < global_position.x else false
		
	_velocity = steering.follow(
		_velocity,
		global_position,
		target_global_position,
		max_speed,
		SLOW_RADIUS)
	
	_velocity = move_and_slide(_velocity)


func pickUp(temp_tool):
	if curr_tool:
		curr_tool.free()
	curr_tool = load("res://Assets/Tool.tscn").instance()
	print("picking up from temp_tool: ",temp_tool.tool_type)
	curr_tool.new(temp_tool) #tool properties
	print("picking up after new: ",temp_tool.tool_type)
	temp_tool.free()
	self.add_child(curr_tool)
	print("picking up: ",curr_tool.tool_type)
	curr_tool.pickUp()
	if curr_tool.tool_type == "hammer":
		bp = bp*5

func _unselect():
	selected = false
	label.visible = false

func _select():
	selected = true
	label.visible = true
	
func gui_show():
	get_parent().GUI.close()
	if unit_type == "civilian":
		get_parent().GUI.show_civilian()
	if unit_type == "explorer":
		get_parent().GUI.show_explorer()
	if unit_type == "knight":
		get_parent().GUI.show_knight()
	if unit_type == "rogue":
		get_parent().GUI.show_rogue()


