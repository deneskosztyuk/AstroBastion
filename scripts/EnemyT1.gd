extends CharacterBody2D

@export var speed = 70
@export var damage = 10
@export var max_health = 50
@export var resource_value = 10
@onready var healthbar = $Healthbar  # Ensure this is the correct path to your health bar node
@onready var explosion_scene: PackedScene = preload("res://Scenes/explosion.tscn")
@onready var death_timer = $DeathTimer  # Ensure this is the correct path to your timer node
@onready var explosion = $"Explosion"
@onready var animated_sprite_2d = $AnimatedSprite2D


var spaceship = null
var direction = Vector2.ZERO
var is_dead = false  # Flag to indicate if the enemy is dead

func _ready():
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	healthbar.init_health(max_health)
	add_to_group("enemies")
	
	# Ensure spaceship reference is valid
	spaceship = get_parent().get_node_or_null("/root/MainGame/Spaceship")
	if spaceship == null:
		push_error("Spaceship node not found!")
	else:
		look_at(spaceship.global_position)

func _physics_process(delta):
	if is_instance_valid(spaceship) and not is_dead:
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
	if is_dead:
		return  # Do nothing if the enemy is already dead
	
	print("Enemy took damage:", amount)
	var new_health = healthbar.health - amount
	healthbar.set_health(new_health)
	if new_health <= 0:
		die()

func die():
	if is_dead:
		return  # Prevent multiple calls to die()

	is_dead = true  # Set the flag to indicate the enemy is dead
	print("Enemy died")
	
	# Set the visibility of the AnimatedSprite2D node to false
	animated_sprite_2d.visible = false  # Replace with your actual path to the AnimatedSprite2D node
	
	
	# Notify the GameMaster to add resources and increment the kill count
	var game_master = get_parent().get_node("/root/MainGame/GameMaster")
	if game_master:
		game_master.add_resource(resource_value)
		game_master.increment_kill_count()
	
	# Play the explosion animation and sound effect
	var explosion_instance = explosion_scene.instantiate()
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)

	explosion.play()
	
	# Start the death timer to queue_free the enemy after 1 second
	death_timer.start()
	death_timer.connect("timeout", Callable(self, "_on_death_timer_timeout"))


func _on_death_timer_timeout():
	queue_free()
