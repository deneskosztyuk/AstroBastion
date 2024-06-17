extends CharacterBody2D

@export var Projectile: PackedScene
@onready var target_lock_zone = $TargetLockZone
@onready var front_reference = $FrontReference
@export var _rotation_speed = 3.0
@export var shooting_interval = 0.4  

var is_shooting = false
var target = null

func _ready():
	$ShootTimer.connect("timeout", Callable(self, "_on_shoot_timer_timeout"))
	$ShootTimer.set_wait_time(shooting_interval)
	$ShootTimer.set_one_shot(false)

func _physics_process(delta):
	if target and target.is_in_group("enemies"):
		var direction_to_target = (target.global_position - global_position).normalized()
		var direction_to_front = (front_reference.global_position - global_position).normalized()
		var angle_to_target = direction_to_front.angle_to(direction_to_target)
		var rotation_direction = 1 if angle_to_target > 0 else -1
		rotation += rotation_direction * min(abs(angle_to_target), _rotation_speed * delta)


func shoot_at(target_enemy):
	if Projectile and target_enemy.is_in_group("enemies"):
		var projectile = Projectile.instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = $ProjectileSpawnPoint.global_position
		var projectile_direction = (front_reference.global_position - global_position).normalized()
		projectile.launch(projectile_direction)

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		target = body
		is_shooting = true
		$ShootTimer.start()

func _on_area_2d_body_exited(body):
	if body == target:
		target = null
		is_shooting = false
		$ShootTimer.stop()

func _on_shoot_timer_timeout():
	if is_shooting and target and target.is_in_group("enemies"):
		shoot_at(target)
