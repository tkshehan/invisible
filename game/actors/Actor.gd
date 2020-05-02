extends StaticBody2D
class_name Actor

onready var tween = $Tween
onready var ray = $RayCast2D
var speed = 6

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
	## Correct if inputting 2 directions at once
	if dir.y != 0 and dir.x != 0:
		ray.cast_to = Vector2(0, dir.y) * tile_size
		ray.force_raycast_update()
		if !ray.is_colliding():
			dir = Vector2(0, dir.y)
		else:
			dir = Vector2(dir.x, 0)
	ray.cast_to = dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
#		$AnimationPlayer.play(dir)
		move_tween(dir)
		
func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + dir * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func get_dir():
	pass

func _on_Tween_tween_completed(_object: Object, key: NodePath) -> void:
	emit_signal("moved")
