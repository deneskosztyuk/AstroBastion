# Projectile.gd
extends RigidBody2D

@export var speed = 500
var velocity = Vector2()

@onready var sprite = $AnimatedSprite2D

func _ready():
	self.connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta):
	move_and_collide(velocity * delta)
	sprite.play("flying")

func launch(dir):
	velocity = dir.normalized() * speed

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(10)  # Replace with your damage value
	queue_free()
