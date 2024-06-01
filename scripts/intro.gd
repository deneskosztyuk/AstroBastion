extends Control

@onready var labels = [
	$VBoxContainer/DialogueLabel1,
	$VBoxContainer/DialogueLabel2,
	$VBoxContainer/DialogueLabel3,
	$VBoxContainer/DialogueLabel4
]

var current_label_index = 0

func _ready():
	# Connect the input event
	set_process_input(true)
	update_labels()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		current_label_index += 1
		if current_label_index < labels.size():
			update_labels()
		else:
			load_main_game()

func update_labels():
	for i in range(labels.size()):
		labels[i].visible = (i == current_label_index)

func load_main_game():
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")
