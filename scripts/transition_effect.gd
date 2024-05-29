extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready():
	# Start the fade-in animation
	animation_player.play("fade_in")
	# Ensure the signal is connected using Callable, checking if it is already connected
	if not animation_player.is_connected("animation_finished", Callable(self, "_on_animation_player_animation_finished")):
		animation_player.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		# Change to main menu scene when the fade-in is complete
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		# Remove the TransitionEffect from the scene tree
		queue_free()
