extends AudioStreamPlayer2D

onready var sounds = {
	"lock_on": load("res://assets/sfx/robot_lockon.wav"),
}

func _ready():
	volume_db = -30

func lock_on():
	stream = sounds['lock_on']
	play()
