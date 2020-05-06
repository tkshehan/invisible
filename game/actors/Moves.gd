extends Node2D

func has_liberties():
	for ray in get_children():
		if ray is Timer:
			continue
		ray.force_raycast_update()
		if !ray.is_colliding():
			return true
	print(' ')
	return false
	
func finish_him():
	globals.stop_music()
	$DeathTimer.start()

func _on_DeathTimer_timeout() -> void:
	for ray in get_children():
		if ray is Timer:
			continue
		if ray.is_colliding():
			var body = ray.get_collider()
			if body is Enemy:
				body.player_moved()
