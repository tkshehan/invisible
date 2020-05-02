extends AudioStreamPlayer2D

onready var sounds = {
	"cloaking": load("res://assets/sfx/Cloaking.wav"),
	"uncloaking": load("res://assets/sfx/Uncloaking.wav")
}

func _ready():
	volume_db = -20

func cloak():
	stream = sounds['cloaking']
	play()
	
func uncloak():
	stream = sounds['uncloaking']
	play()
