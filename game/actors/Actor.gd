extends StaticBody2D
class_name Actor

onready var tween = $Tween
onready var ray = $RayCast2D
var speed = 6

signal bumped(body, dir)
signal moved

var tile_size = 32

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	$AnimationPlayer.playback_speed = speed

func _process(_delta):
	if tween.is_active():
		return
	var dir = get_dir()
	if dir != null:
		move(dir)
			
func move(dir):
	ray.cast_to = dir * (tile_size * 1.4)
	ray.force_raycast_update()
	if !ray.is_colliding():
#		$AnimationPlayer.play(dir)
		move_tween(dir)
	else:
		emit_signal("bumped", ray.get_collider(), dir)
		
func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + dir * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func get_dir():
	pass

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	emit_signal("moved")
