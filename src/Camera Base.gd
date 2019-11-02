extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MARGIN = 50
const MOVE_SPEED = 100
var start_position = Vector2(200,200)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_global_position(start_position)
	pass # Replace with function body.

func calc_move(m_pos,delta):
	var v_size = get_viewport().size
	var move_vec = Vector2()
	if m_pos.x < MARGIN/2:
		move_vec.x -= 3
	if m_pos.y < MARGIN/2:
		move_vec.y -= 3
	if m_pos.x > v_size.x - MARGIN/2:
		move_vec.x += 3
	if m_pos.y > v_size.y - MARGIN/2:
		move_vec.y += 3
	if m_pos.x < MARGIN:
		move_vec.x -= 1
	if m_pos.y < MARGIN:
		move_vec.y -= 1
	if m_pos.x > v_size.x - MARGIN:
		move_vec.x += 1
	if m_pos.y > v_size.y - MARGIN:
		move_vec.y += 1
	global_translate(move_vec * delta * MOVE_SPEED)

func _process(delta):
	var m_pos = get_viewport().get_mouse_position()
	calc_move(m_pos, delta)