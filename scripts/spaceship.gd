# spaceship.gd
extends Node2D

@onready var collision = $CharacterBody2D/CollisionShape2D
@onready var healthbar = $CharacterBody2D/Healthbar  # Adjusted path to correctly reference the healthbar

func _ready():
	var health = 100
	healthbar.init_health(health)
