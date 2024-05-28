extends StaticBody2D

@onready var sprite = $Sprite2D
@onready var detection_area = $Area2D
@onready var timer = $Timer

var detection_radius = 100
var shooting_interval = 1.0
var target = null

func _ready():
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.wait_time = shooting_interval
	timer.start()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		target = body

func _on_body_exited(body):
	if body == target:
		target = null

func _on_timer_timeout():
	if target:
		shoot_at(target)

func shoot_at(target):
	# Logic to shoot at the target
	pass
