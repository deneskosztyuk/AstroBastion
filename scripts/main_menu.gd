extends Control

func _ready():
	# Connect the button signals to the corresponding functions
	$Panel/VBoxContainer/NewGameButton.pressed.connect(_on_NewGameButton_pressed)
	$Panel/VBoxContainer/OptionsButton.pressed.connect(_on_OptionsButton_pressed)
	$Panel/VBoxContainer/CreditButton.pressed.connect(_on_CreditButton_pressed)
	$Panel/VBoxContainer/ExitButton.pressed.connect(_on_ExitButton_pressed)

	# Update the labels with the data from the last playthrough
	var kill_count_label = $Panel/VBoxContainer/KillCountLabel
	var survival_time_label = $Panel/VBoxContainer/SurvivalTimeLabel

	kill_count_label.text = "Last Kill Count: " + str(GameData.kill_count)
	survival_time_label.text = "Last Survival Time: " + str(GameData.survival_time) + " seconds"

func _on_NewGameButton_pressed():
	# Load the MainGame scene
	get_tree().paused = false
	GameData.reset_data()  # Reset data for the new game
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")

func _on_OptionsButton_pressed():
	# Placeholder for OptionsButton functionality
	print("Options button pressed")

func _on_CreditButton_pressed():
	# Placeholder for CreditButton functionality
	print("Credit button pressed")

func _on_ExitButton_pressed():
	# Terminate the game
	get_tree().quit()
