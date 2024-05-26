extends Node2D

# Declare the health variable
var health: int = 100

# Function to take damage
func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

# Function to handle spaceship destruction
func die():
	queue_free()  # or implement a more complex destruction logic
