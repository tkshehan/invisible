extends Actor
class_name Enemy

onready var turns = 0
onready var agressive = false
export(String, "up", "down", "left", "right") var direction = "down"
var directions = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
onready var target = self

signal collision(body1, body2)
signal killed_player

func _ready():
	speed = 10
	var _err = connect("bumped", self, "_on_bump")
	$VisionAxis.look(directions[direction])
	look_for_player()
	
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
	var found_target = false
	for body in $VisionAxis/Vision.check_vision():
		var _target = target
		if body is Decoy:
			_target = body
			turn_aggressive()
		if body is Player and not _target is Decoy:
			_target = body
			turn_aggressive()
		target = _target
		found_target = true
	return found_target
			
func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	#Check is overlapping with another body
	ray.cast_to = Vector2(0,1)
	ray.force_raycast_update()
	if ray.is_colliding():
		emit_signal("collision", self, ray.get_collider())
	#Correct facing if enemy is target
	if target != self:
		var points = globals.nav.find_simple_path(
		self.position,
		target.position
		)
		if points.size()  >= 2:
			var dir = points[1] - points[0]
			var dir_norm = dir.normalized().round()
			if !look_for_player():
				$VisionAxis.look(dir_norm)
	emit_signal("moved")
	look_for_player()
	
func turn_aggressive():
	if agressive:
		return
	$RobotSounds.lock_on()
	$Sprite.frame = 1
	agressive = true
	turns -= 1
	$VisionAxis/Light2D.color = Color(0.4, 0, 0, 0.4)

func check_target():
	if not is_instance_valid(target):
		target = self
		agressive = false
		$Sprite.frame = 0
		$VisionAxis/Light2D.color = Color(0.4, 0.4, 0, 0.4)

func _on_bump(body):
	if body is Actor:
		if body is Player:
			emit_signal("killed_player")

