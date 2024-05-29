# TurretT1.gd
extends CharacterBody2D

@export var Projectile: PackedScene
@onready var target_lock_zone = $TargetLockZone

var target = null

func _physics_process(_delta):
	if target:
		var dir = (target.global_position - global_position).normalized()
		# Rotate the turret to face the target
		rotation = dir.angle()
		shoot(target)

func shoot(target):
	if Projectile:
		var projectile_instance = Projectile.instantiate()
		get_parent().add_child(projectile_instance)
		projectile_instance.global_position = global_position
		var dir = (target.global_position - global_position).normalized()
		projectile_instance.launch(dir)

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"): # Check if the body is an enemy
		target = body

func _on_area_2d_body_exited(body):
	if body == target: # If the target has left the range
		target = null
