extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var health = 0
var max_health = 0

func set_health(new_value):
	var prev_health = health
	health = min(max_health, new_value)
	value = health
	if health <= 0:
		queue_free()
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func init_health(new_health):
	health = new_health
	max_health = new_health
	value = new_health
	damage_bar.max_value = new_health
	damage_bar.value = new_health

func _on_timer_timeout():
	damage_bar.value = health
