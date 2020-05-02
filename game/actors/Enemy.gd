extends Actor
class_name Enemy

var turns = 0
	
func player_moved():
	turns += 1

func get_dir():
	if turns == 0:
		return null
	turns -= 1
	
	var points = globals.nav.find_simple_path(
		self.position,
		globals.target
	)
	if points.size() < 2:
		emit_signal("moved")
		return
		
	var dir = points[1] - points[0]
	var dir_norm = dir.normalized().round()
	if abs(dir.y) > abs(dir.x):
		return Vector2(0, dir_norm.y)
	elif abs(dir.x) > abs(dir.y):
		return Vector2(dir_norm.x, 0)
	else:
		return dir_norm
	
	
