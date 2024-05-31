extends CharacterBody2D

@export var Projectile: PackedScene
@onready var target_lock_zone = $TargetLockZone
@export var _rotation_speed = 3.0
@export var shooting_interval = 0.5  # Adjust the shooting interval as needed

var is_shooting = false
var target = null

func _ready():
	$ShootTimer.connect("timeout", Callable(self, "_on_shoot_timer_timeout"))
	$ShootTimer.set_wait_time(shooting_interval)
	$ShootTimer.set_one_shot(false)

func _physics_process(delta):
	if target and target.is_in_group("enemies"):
		var direction = (target.global_position - global_position).normalized()
		var target_angle = direction.angle()
		rotation = lerp_angle(rotation, target_angle, delta * _rotation_speed)

func shoot_at(target_enemy):
	if Projectile and target_enemy.is_in_group("enemies"):
		var projectile = Projectile.instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = $ProjectileSpawnPoint.global_position
		var direction = (target_enemy.global_position - $ProjectileSpawnPoint.global_position).normalized()
		projectile.launch(direction)

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
