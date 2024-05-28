extends CharacterBody2D

@export var speed = 70
var spaceship = null  

var direction = Vector2.ZERO

func _ready():
	randomize_position()
	# Ensure spaceship reference is valid
	if spaceship == null:
		spaceship = get_parent().get_node_or_null("/root/MainGame/Spaceship")
		if spaceship == null:
			push_error("Spaceship node not found!")
	# Connect the area_entered signal
	$Area2D.connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta):
	if spaceship:
		direction = (spaceship.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_area_entered(area):
	if area.name == "Spaceship":
		area.take_damage(10)
		queue_free()

func randomize_position():
	var rand_x = randf_range(-200.0, 2300.0)
	var rand_y = randf_range(-200.0, 1500.0)
	global_position = Vector2(rand_x, rand_y)

func set_spaceship(spaceship_node):
	spaceship = spaceship_node
