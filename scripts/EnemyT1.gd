# EnemyT1.gd
extends CharacterBody2D

@export var speed = 70
@export var damage = 10
@export var max_health = 50
@onready var healthbar = $Healthbar  # Ensure this is the correct path to your health bar node

var spaceship = null
var direction = Vector2.ZERO

func _ready():
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	healthbar.init_health(max_health)
	add_to_group("enemies")
	
	# Ensure spaceship reference is valid
	spaceship = get_parent().get_node_or_null("/root/MainGame/Spaceship")
	if spaceship == null:
		push_error("Spaceship node not found!")

func _physics_process(delta):
	if is_instance_valid(spaceship):
		direction = (spaceship.global_position - global_position).normalized()
		velocity = direction * speed
		
		var collision = move_and_collide(velocity * delta)
		if collision:
			var collider = collision.get_collider()
			if collider == spaceship:
				print("Spaceship collision detected")
				spaceship.take_damage(damage)
				queue_free()
	else:
		spaceship = null  # Handle case when spaceship is no longer valid

func take_damage(amount):
	var new_health = healthbar.health - amount
	healthbar.set_health(new_health)
	if new_health <= 0:
		die()

func die():
	queue_free()
