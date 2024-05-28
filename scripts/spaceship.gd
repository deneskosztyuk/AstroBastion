# spaceship.gd
extends Node2D

@onready var collision = $CharacterBody2D/CollisionShape2D
@onready var healthbar = $CharacterBody2D/Healthbar

var health = 100

func _ready():
	healthbar.init_health(health)

func take_damage(amount):
	health -= amount
	healthbar.value = health  # Update the health bar value
	if health <= 0:
		die()

func die():
	queue_free()  # Placeholder for spaceship destruction logic
	# You can add additional logic here for game over, explosion animation, etc.
