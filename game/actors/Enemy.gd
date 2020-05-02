extends Actor
class_name Enemy

var turns = 1000
var target

func _ready():
	target = globals.player
	speed = 3

func get_dir():
	if turns == 0:
		return null
	var points = globals.nav.find_simple_path(
		self.position,
		target.position
	)
	var dir = points[1] - points[0]
	var dir_norm = dir.normalized().round()
	if abs(dir.y) > abs(dir.x):
		return Vector2(0, dir_norm.y)
	elif abs(dir.x) > abs(dir.y):
		return Vector2(dir_norm.x, 0)
	else:
		return dir_norm
	
	
