extends Node2D

@onready var spaceship = get_node_or_null("/root/MainGame/Spaceship")
@export var enemy_scene = preload("res://Scenes/enemy_t_1.tscn")
@export var TurretT1 = preload("res://Scenes/TurretT1.tscn")
@onready var spawn_timer = $SpawnTimer
@export var UI = preload("res://Scenes/UI.tscn")

var turret_instance = null
var ui_instance = null

func _ready():
	if spaceship == null:
		push_error("Spaceship node not found!")
	
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.wait_time = 5.0 # Set the time interval for spawning enemies
	spawn_timer.start()
	
	# Instantiate the UI scene and add it to the main scene
	ui_instance = UI.instantiate()
	add_child(ui_instance)
	
	# Connect the turret_button_pressed signal to the _on_turret_t_1_button_2_pressed function
	ui_instance.connect("turret_button_pressed", Callable(self, "_on_turret_t_1_button_2_pressed"))

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if turret_instance:
			# Place the turret at the mouse position
			turret_instance.global_position = get_global_mouse_position()
			# Add the turret to the scene
			add_child(turret_instance)
			# Reset the turret instance
			turret_instance = null

func _on_spawn_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	var rand_x = randf_range(-200.0, 2300.0)
	var rand_y = randf_range(-200.0, 1500.0)
	enemy_instance.global_position = Vector2(rand_x, rand_y)
	add_child(enemy_instance)

func _on_turret_t_1_button_2_pressed(turret_type):
	if turret_type == "TurretT1":
		# Create a new instance of the TurretT1 scene
		turret_instance = TurretT1.instantiate()
