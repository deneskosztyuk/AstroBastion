extends Node2D

@onready var spaceship = get_node_or_null("/root/MainGame/Spaceship")
@export var enemy_scene = preload("res://Scenes/enemy_t_1.tscn")
@onready var spawn_timer = $SpawnTimer

func _ready():
	if spaceship == null:
		push_error("Spaceship node not found!")
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.wait_time = 5.0 # Set the time interval for spawning enemies
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	var rand_x = randf_range(-200.0, 2300.0)
	var rand_y = randf_range(-200.0, 1500.0)
	enemy_instance.global_position = Vector2(rand_x, rand_y)
	add_child(enemy_instance)
