extends Area2D


onready var parent = get_parent()
var mouse_over

func _ready():
	set_collision_layer(1)
	$CollisionShape2D.set_shape(parent.get_collision_shape())
	if "Building" in parent.name:
		if parent.building_type == "workshop":
			set_collision_layer(1)
			parent.set_collision_layer(0)


func _input(event):
	if mouse_over and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if parent.is_in_group("units"):
			parent.remove_from_group("units")
			get_tree().call_group("units","_unselect")
			parent.add_to_group("units")
			parent._select()
			parent.get_parent().selected = parent
		else:
			get_tree().call_group("units","_unselect")
			parent.store_location()
		parent.gui_show()
			

		
		parent.selected = true
		

func _on_Clickable_mouse_entered():
	mouse_over = true


func _on_Clickable_mouse_exited():
	mouse_over = false # Replace with function body.
