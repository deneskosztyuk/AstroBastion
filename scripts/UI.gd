extends Node2D

signal turret_button_pressed(turret_type)

func _on_turret_t_1_button_2_pressed():
	# Emit the turret_button_pressed signal with the turret type
	emit_signal("turret_button_pressed", "TurretT1")
