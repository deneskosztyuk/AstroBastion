extends CharacterBody2D

@export var speed = 500
var _velocity = Vector2()
@onready var sprite = $Area2D/AnimatedSprite2D

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var collision = move_and_collide(_velocity * delta)
	if collision:
		handle_collision(collision)

func launch(dir):
	_velocity = dir.normalized() * speed
	set_physics_process(true)
	sprite.play("flying")

func _on_area_2d_body_entered(body):
	print("Projectile collided with:", body)
	if body.has_method("take_damage"):
		body.take_damage(10)  
		queue_free()  # Destroy the projectile after collision

func handle_collision(_collision):
	# Handle collision logic, e.g., apply damage or destroy the projectile
	queue_free()
