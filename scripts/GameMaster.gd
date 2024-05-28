extends Node2D

@onready var spaceship = get_node_or_null("/root/MainGame/Spaceship")
@export var enemy_scene = preload("res://Scenes/enemy_t_1.tscn")  # Adjust the path as necessary
@onready var spawn_timer = $SpawnTimer

func _ready():
	if spaceship == null:
		push_error("Spaceship node not found!")
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.wait_time = 5.0  # Set the time interval for spawning enemies
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	# Randomize enemy spawn position within the specified range
	var rand_x = randf_range(-100.0, 2000.0)  # Use randf_range for floating point numbers
	var rand_y = randf_range(-100.0, 1200.0)  # Use randf_range for floating point numbers
	enemy_instance.global_position = Vector2(rand_x, rand_y)
	add_child(enemy_instance)
	if spaceship != null:
		enemy_instance.set_spaceship(spaceship)  # Pass the spaceship reference to the enemy instance
