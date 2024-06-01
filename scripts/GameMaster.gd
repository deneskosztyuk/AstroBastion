extends Node2D

@onready var spaceship = get_node_or_null("/root/MainGame/Spaceship")
@export var enemy_scene = preload("res://Scenes/enemy_t_1.tscn")
@export var TurretT1 = preload("res://Scenes/TurretT1.tscn")
@onready var spawn_timer = $SpawnTimer
@export var UI = preload("res://Scenes/UI.tscn")

var turret_instance = null
var ui_instance = null
var max_turrets_t1 = 3
var turret_count_t1 = 0
var resource = 50
var turret_cost = 50
var kill_count = 0
var elapsed_time = 0
var timer = Timer.new()

func _ready():
	if spaceship == null:
		push_error("Spaceship node not found!")
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_timer.wait_time = 5.0 # Set the time interval for spawning enemies
	spawn_timer.start()

	# Instantiate the UI scene and add it to the main scene
	ui_instance = UI.instantiate()
	add_child(ui_instance)

	print("UI instance added to the scene.")
	update_turret_count_label_t1()
	update_resource_label()
	update_kill_count_label()
	update_time_remaining_label()

	# Connect the turret_button_pressed signal to the _on_turret_button_pressed function
	ui_instance.connect("turret_button_pressed", Callable(self, "_on_turret_button_pressed"))

	# Setup and start the timer
	timer.wait_time = 1.0
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.start()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if turret_instance:
			# Place the turret at the mouse position
			turret_instance.global_position = get_global_mouse_position()
			# Add the turret to the scene
			add_child(turret_instance)
			update_turret_count_label_t1()
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

func _on_turret_button_pressed(turret_type):
	if turret_type == "TurretT1":
		if turret_count_t1 < max_turrets_t1 and resource >= turret_cost:
			turret_instance = TurretT1.instantiate()
			turret_count_t1 += 1
			resource -= turret_cost
			update_turret_count_label_t1()
			update_resource_label()

func update_turret_count_label_t1():
	print("Updating turret count label.")
	var turret_count_label = ui_instance.get_node("Camera2D/Control/CanonTurret/TurretsInSceneLabelT1")
	if turret_count_label:
		turret_count_label.text = str(turret_count_t1) + "/" + str(max_turrets_t1)
	else:
		push_error("Turret count label not found!")

func update_resource_label():
	var resource_label = ui_instance.get_node("Camera2D/Control/Resource/ResourceLabel")
	if resource_label:
		resource_label.text = "Resource: " + str(resource)
	else:
		push_error("Resource label not found!")

func update_kill_count_label():
	var kill_count_label = ui_instance.get_node("Camera2D/Control/KillCount/KillCountIcon/KillCountLabel")
	if kill_count_label:
		kill_count_label.text = "Kill Count: " + str(kill_count)
	else:
		push_error("Kill count label not found!")

func update_time_remaining_label():
	var time_remaining_label = ui_instance.get_node("Camera2D/Control/TimeRemaining/TimeRemainingObj/TimeRemainingLabel")
	if time_remaining_label:
		time_remaining_label.text = "Survived for: " + str(elapsed_time) + " seconds."
	else:
		push_error("Time remaining label not found!")

func add_resource(amount):
	resource += amount
	update_resource_label()

func increment_kill_count():
	kill_count += 1
	update_kill_count_label()
	GameData.update_kill_count(1)  # Update the global kill count

func _on_timer_timeout():
	elapsed_time += 1
	update_time_remaining_label()
	GameData.update_survival_time(1.0)  # Update the global survival time

func spaceship_destroyed():
	print("Spaceship destroyed. Elapsed time: " + str(elapsed_time))
	timer.stop()
	GameData.set_final_data(kill_count, float(elapsed_time))  # Set the final data
