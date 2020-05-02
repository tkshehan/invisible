extends Actor
class_name Player

var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

func _ready():
	globals.player = self

func get_dir():
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			return inputs[dir]

