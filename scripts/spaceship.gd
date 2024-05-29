extends CharacterBody2D

@onready var healthbar = $Healthbar
@export var transition_effect = preload("res://Scenes/transition_effect.tscn")

var max_health = 200

func _ready():
	set_collision_layer_value(1, true)
	set_collision_mask_value(2, true)
	healthbar.init_health(max_health)

func take_damage(amount):
	var new_health = healthbar.health - amount
	healthbar.set_health(new_health)
	if new_health <= 0:
		die()

func die():
	var transition_instance = transition_effect.instantiate()
	get_tree().root.add_child(transition_instance)

	# Use a call deferred to ensure scene change is handled correctly
	call_deferred("_deferred_free")

func _deferred_free():
	queue_free()
