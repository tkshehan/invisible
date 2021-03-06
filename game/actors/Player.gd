extends Actor
class_name Player

var cloaked = false
var cloak_timer = 3
export var cloaks_left: = 1

var alive = true
var waiting = false

signal cloaked
signal uncloaked

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

	
func _process(_delta):
		if Input.is_action_pressed("cloak") and not cloaked and alive:
			cloak()

func get_dir():
	if not alive or !$Timer.is_stopped() or waiting:
		return
	if $Moves.has_liberties() == false:
		waiting = true
		$Sprite.frame = 0
		$Moves.finish_him()
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			set_frame(dir)
			return inputs[dir]

func move_tween(dir):
	.move_tween(dir)
	$FootSteps.play()

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	end_turn()
	
func end_turn():
	emit_signal("moved")
	$Timer.start()
	if cloak_timer == 0:
		uncloak()
		
	if cloaked:
		cloak_timer -= 1

		
func cloak():
	if tween.is_active():
		return
	if cloaked or cloaks_left == 0:
		return
	cloaks_left -= 1
	set_collision_layer_bit(1, false)
	set_collision_layer_bit(4, true)
	$Sprite.set_frame(0)
	$CloakSounds.cloak()
	cloaked = true
	
	modulate = Color(1, 1, 1, 0.5)
	emit_signal("cloaked")

func uncloak():
	set_collision_layer_bit(1, true)
	set_collision_layer_bit(4, false)
	$Sprite.set_frame(1)
	$CloakSounds.uncloak()
	cloaked = false
	cloak_timer = 3
	modulate = Color(1,1,1,1)
	emit_signal("uncloaked")

func set_frame(dir):
	if dir == "move_down":
		$Sprite.frame = 0
	if dir == "move_left":
		$Sprite.frame = 1
	if dir == "move_up":
		$Sprite.frame = 2
	if dir == "move_right":
		$Sprite.frame = 3

func kill():
	waiting = false
	alive = false
	$CloakSounds.death()
	$Sprite.frame = 4
	pass
