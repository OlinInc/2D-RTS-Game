extends StaticBody2D

var tool_type_dic = {"basic_sword":Rect2(112,108,7,20),"hammer":Rect2(120,108,8,20),"longsword":Rect2(229,0,8,32)}
var tool_type
onready var sprite = $Sprite
onready var animator = $Sprite/AnimationPlayer
var built = true
var forging

func get_collision_shape():
	return $CollisionShape2D.shape

func new(old_tool):
	$CollisionShape2D.disabled = true
	tool_type = old_tool.tool_type
	$Sprite.set_region_rect(tool_type_dic[old_tool.tool_type])
	scale = scale/2

func use(flip_h,bp):
	animator.playback_speed *= bp
	animator.play("use")
	animator.playback_speed /= bp
	

func _ready():
	pass

func init(kind,loc,built):
	sprite.rotation = 0
	built = built
	sprite.set_region_rect(tool_type_dic[kind])
	tool_type = kind
	set_position(loc)
	
	

func pickUp():
	set_collision_layer(0)
	set_collision_mask(0)

func _process(delta):
	if "Unit" in get_parent().name:
		set_position(Vector2(-4.5,.5)) if get_parent().sprite.flip_h else set_position(Vector2(4.5,.5))
	if not built:
		if forging >= 100:
			built = true