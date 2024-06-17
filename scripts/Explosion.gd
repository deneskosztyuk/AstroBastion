extends Node2D

@onready var particle_system = $CPUParticles2D
@onready var explosion_sfx = $ExplosionSFX

func _ready():
	# Play the explosion animation
	particle_system.emitting = true
	
	# Play the explosion sound effect
	explosion_sfx.play()
	
	# Queue free the explosion node after the animation duration
	await get_tree().create_timer(particle_system.lifetime).timeout
	queue_free()
