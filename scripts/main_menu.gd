extends Control

@onready var audio_player_click = $ClickSoundPlayer
@onready var audio_player_bg = $BackgroundMusicPlayer
@onready var scene_switch_timer = $SceneSwitchTimer

func _ready():
	# Connect the button signals to the corresponding functions
	$Panel/VBoxContainer/NewGameButton.pressed.connect(_on_new_game_button_pressed)
	$Panel/VBoxContainer/OptionsButton.pressed.connect(_on_OptionsButton_pressed)
	$Panel/VBoxContainer/CreditButton.pressed.connect(_on_CreditButton_pressed)
	$Panel/VBoxContainer/ExitButton.pressed.connect(_on_ExitButton_pressed)

	# Connect the timer timeout signal to the function that changes the scene
	scene_switch_timer.timeout.connect(_on_SceneSwitchTimer_timeout)

	# Update the labels with the data from the last playthrough
	var kill_count_label = $Panel/VBoxContainer/KillCountLabel
	var survival_time_label = $Panel/VBoxContainer/SurvivalTimeLabel

	kill_count_label.text = "Last Kill Count: " + str(GameData.kill_count)
	survival_time_label.text = "Last Survival Time: " + str(GameData.survival_time) + " seconds"

	# Play background music if needed
	if audio_player_bg:
		audio_player_bg.play()

func _on_new_game_button_pressed():
	# Play click sound
	audio_player_click.play()
	
	# Start the timer to delay the scene switch
	scene_switch_timer.start()

func _on_OptionsButton_pressed():
	# Play click sound
	audio_player_click.play()
	print("Options button pressed")

func _on_CreditButton_pressed():
	# Play click sound
	audio_player_click.play()
	print("Credit button pressed")

func _on_ExitButton_pressed():
	# Play click sound
	audio_player_click.play()
	# Terminate the game
	get_tree().quit()

func _on_SceneSwitchTimer_timeout():
	# Load the Intro scene after the delay
	get_tree().paused = false
	GameData.reset_data()  # Reset data for the new game
	get_tree().change_scene_to_file("res://Scenes/Intro.tscn")
