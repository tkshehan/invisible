extends Node2D


func check_vision():
	var points = []
	var bodies = []
	for ray in get_children():
		if !ray is RayCast2D:
			continue
		ray.force_raycast_update()
		var point = ray.get_collision_point()
		var coll = ray.get_collider()
		if coll != null:
			bodies.append(coll)
		if point == null or coll is Player or coll is Decoy:
			point = ray.cast_to
		else:
			point = to_local(point)
		points.append(point)
	return bodies
