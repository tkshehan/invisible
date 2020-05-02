extends Actor
class_name Player

var cloaked = false
var cloak_timer = 3

signal cloaked
signal uncloaked

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

func _ready():
	globals.target = self.position
	
func _process(_delta):
		if Input.is_action_pressed("cloak") and not cloaked:
			cloak()
			if tween.is_active():
				cloak_timer += 1

func get_dir():
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			return inputs[dir]

func _on_Tween_tween_completed(_object: Object, key: NodePath) -> void:
	emit_signal("moved")
	if cloak_timer == 0:
		uncloak()
		
	if cloaked:
		cloak_timer -= 1
	else:
		globals.target = self.position
		
func cloak():
	if cloaked:
		return
	$Sprite.set_frame(0)
	$PlayerSounds.cloak()
	cloaked = true
	modulate = Color(1, 1, 1, 0.5)
	emit_signal("cloaked")

func uncloak():
	$Sprite.set_frame(1)
	$PlayerSounds.uncloak()
	cloaked = false
	cloak_timer = 3
	modulate = Color(1,1,1,1)
	emit_signal("uncloaked")
