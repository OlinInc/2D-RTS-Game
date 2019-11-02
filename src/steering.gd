extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const DEFAULT_MASS = 2.0
const DEFAULT_MAX_SPEED = 400.0
const DEFAULT_SLOW_RADIUS = 200.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

static func follow(
		velocity: Vector2,
		global_position: Vector2,
		target_position: Vector2,
		max_speed: = DEFAULT_MAX_SPEED,
		slow_radius = DEFAULT_SLOW_RADIUS,
		mass: = DEFAULT_MASS
	) -> Vector2:
	var to_target = global_position.distance_to(target_position)
	var desired_velocity = (target_position-global_position).normalized() * max_speed
	if to_target < slow_radius:
		desired_velocity = desired_velocity * (to_target/slow_radius) *.9
	var steering = (desired_velocity - velocity) / mass
	return velocity + steering