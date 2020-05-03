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
	if Input.is_action_just_pressed("wait"):
		end_turn()
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			$FootSteps.play()
			set_frame(dir)
			return inputs[dir]

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	end_turn()
	
func end_turn():
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
	layers = 0
	$Sprite.set_frame(0)
	$CloakSounds.cloak()
	cloaked = true
	
	modulate = Color(1, 1, 1, 0.5)
	emit_signal("cloaked")

func uncloak():
	layers = 2
	$Sprite.set_frame(1)
	$CloakSounds.uncloak()
	cloaked = false
	cloak_timer = 3
	modulate = Color(1,1,1,1)
	emit_signal("uncloaked")

func set_frame(dir):
	print(dir)
	if dir == "move_down":
		$Sprite.frame = 0
	if dir == "move_left":
		$Sprite.frame = 1
	if dir == "move_up":
		$Sprite.frame = 2
	if dir == "move_right":
		$Sprite.frame = 3
