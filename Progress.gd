extends TextureProgress
func _ready():
	if "Unit" in get_parent().name:
		set_position(Vector2(0,10))
		set_scale(Vector2(.05,.05))
	set_min(0)
	set_max(100)


