extends Control

var is_paused = false

func _ready():
	# Connect the button signals to the corresponding functions
	$Panel/VBoxContainer/ResumeButton.pressed.connect(_on_ResumeButton_pressed)
	$Panel/VBoxContainer/MainMenuButton.pressed.connect(_on_MainMenuButton_pressed)
	$Panel/VBoxContainer/OptionsButton.pressed.connect(_on_OptionsButton_pressed)
	$Panel/VBoxContainer/ExitButton.pressed.connect(_on_ExitButton_pressed)
	
	# Hide the EscapeMenu initially
	visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		is_paused = !is_paused
		get_tree().paused = is_paused
		visible = is_paused
		print("Esc key pressed")
		
func _on_ResumeButton_pressed():
	print("Resume button pressed")
	is_paused = false
	get_tree().paused = false
	visible = false
		
		
func _on_MainMenuButton_pressed():
	# Load the MainGame scene
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_OptionsButton_pressed():
	print("Options button pressed")

func _on_ExitButton_pressed():
	print("Exit button pressed")
	get_tree().quit()
