extends StaticBody2D

var health

func _ready():
	health = 100

func _process(delta):
	if health <= 0:
		queue_free()

#func take_hit()