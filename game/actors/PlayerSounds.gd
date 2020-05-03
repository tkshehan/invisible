extends AudioStreamPlayer2D

onready var sounds = {
	"cloaking": load("res://assets/sfx/Cloaking.wav"),
	"uncloaking": load("res://assets/sfx/Uncloaking.wav"),
	"death": load("res://assets/sfx/RobotDeath.wav")
}

func _ready():
	volume_db = -30

func cloak():
	stream = sounds['cloaking']
	play()
	
func uncloak():
	stream = sounds['uncloaking']
	play()

func death():
	stream = sounds['death']
	play()
