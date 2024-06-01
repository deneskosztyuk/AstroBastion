extends Node

# Variables to store kill count and survival time
var kill_count: int = 0
var survival_time: float = 0.0

# Method to reset the data (e.g., when starting a new game)
func reset_data():
	kill_count = 0
	survival_time = 0.0

# Method to update the data (e.g., when a new kill is made or time is updated)
func update_kill_count(count: int):
	kill_count += count

func update_survival_time(time: float):
	survival_time += time

# Method to set the final data after game over
func set_final_data(kills: int, time: float):
	kill_count = kills
	survival_time = time
