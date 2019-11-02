extends StaticBody2D

var rock_type_dic = {"jewel1":Rect2(48,48,16,16),"jewel2":Rect2(32,32,16,16),"jewel3":Rect2(48,32,16,16),"jewel4":Rect2(32,48,16,16)}
var rock_type
var health = 100

func _ready():
	health = 100
	rock_type = rock_type_dic["jewel1"]
	$Sprite.set_region_rect(rock_type_dic["jewel1"])

func _process(delta):
	if 50 < health and health <= 75:
		$Sprite.set_region_rect(rock_type_dic["jewel2"])
	if 25 < health and health <= 50:
		$Sprite.set_region_rect(rock_type_dic["jewel3"])
	if 0 < health and health <= 25:
		$Sprite.set_region_rect(rock_type_dic["jewel4"])
	if health <= 0:
		queue_free()
	