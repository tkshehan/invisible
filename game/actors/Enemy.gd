extends Actor
class_name Enemy

var turns = 0
var agressive = false
export var direction = Vector2.LEFT
var target = self

func _ready():
	$VisionAxis.look(direction)
	
func player_moved():
	look_for_player()
	if(agressive):
		turns += 1
	
func get_dir():
	if turns < 1:
		return null
	turns -= 1
	check_target()
	var points = globals.nav.find_simple_path(
		self.position,
		target.position
	)
	if points.size() < 2:
		emit_signal("moved")
		return
		
	var dir = points[1] - points[0]
	var dir_norm = dir.normalized().round()
	$VisionAxis.look(dir_norm)
	return dir_norm
	
func look_for_player():
	check_target()
	for body in $VisionAxis/Vision.check_vision():
		if body is Decoy: print('decoy')
		if body is Player: print('player')
		if body is Player or body is Decoy:
			target = body
			if !agressive:
				turn_aggressive()
			
func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	emit_signal("moved")
	look_for_player()
	
func turn_aggressive():
	$Sprite.frame = 3
	agressive = true
	turns -= 1

func check_target():
	if not is_instance_valid(target):
		target = self
		agressive = false
		$Sprite.frame = 2
