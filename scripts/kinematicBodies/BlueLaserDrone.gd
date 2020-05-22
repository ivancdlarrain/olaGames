extends Drone

var enemy_in_range = false

func _patrol(delta):
	pass


func _on_DetectionArea_area_entered(area):
	enemy_in_range = true
	print("Enemy entered detection area")
	
	
