extends CharacterBody2D

@export var speed = 70

var spaceship = null
var direction = Vector2.ZERO

func _ready():
	pass
	
	# Ensure spaceship reference is valid
	if spaceship == null:
		spaceship = get_parent().get_node_or_null("/root/MainGame/Spaceship")
		if spaceship == null:
			push_error("Spaceship node not found!")
	
	# Connect the area_entered signal
	var area = get_node_or_null("DetectionArea")  # Replace "DetectionArea" with the actual name of your Area2D node
	if area:
		area.area_entered.connect(_on_area_entered)
	else:
		push_error("Area2D node not found!")

func _process(_delta):
	if spaceship:
		var distance_to_spaceship = global_position.distance_to(spaceship.global_position)
		if distance_to_spaceship > 10:  # Adjust the distance threshold as needed
			direction = (spaceship.global_position - global_position).normalized()
			velocity = direction * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO

func _on_area_entered(area):
	print("Collision detected with:", area)
	if area == spaceship.get_node("CharacterBody2D/CollisionShape2D"):
		spaceship.take_damage(10)
		queue_free()


func set_spaceship(spaceship_node):
	spaceship = spaceship_node
