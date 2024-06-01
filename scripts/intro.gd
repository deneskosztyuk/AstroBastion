extends Node2D

@export var main_game_scene = "res://Scenes/main_game.tscn"  # Use string for the scene path

@onready var labels = [
	$Control/Panel/Label1,
	$Control/Panel/Label2,
	$Control/Panel/Label3,
	$Control/Panel/Label4  # Add more labels as needed
]

var current_label_index = 0

func _ready():
	show_current_label()
	set_process_input(true)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		advance_dialogue()

func advance_dialogue():
	current_label_index += 1
	if current_label_index < labels.size():
		show_current_label()
	else:
		start_main_game()

func show_current_label():
	for i in range(labels.size()):
		labels[i].visible = (i == current_label_index)

func start_main_game():
	get_tree().change_scene_to_file(main_game_scene)
