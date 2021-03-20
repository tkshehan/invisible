extends AudioStreamPlayer

onready var tween = get_node("Tween")

export var transition_duration = 1.00
export var transition_type = 1 # TRANS_SINE
export(String, "EASE_IN", "EASE_OUT", "EASE_IN_OUT", "EASE_OUT_IN") var EASE = "EASE_OUT"
export var fade_volume = -10

func _ready() -> void:
	volume_db = -80
	
var ease_types = {
	"EASE_IN": Tween.EASE_IN,
	"EASE_OUT": Tween.EASE_OUT,
	"EASE_IN_OUT": Tween.EASE_IN_OUT,
	"EASE_OUT_IN": Tween.EASE_OUT_IN
}

func fade_out(dur = transition_duration):
	# tween music volume down
	tween.interpolate_property(self, "volume_db", volume_db, -80, dur, transition_type, ease_types[EASE], 0)
	tween.start()
	yield($Tween, "tween_completed")
	stop()


func fade_in(dur = transition_duration):
	# tween music volume up
	tween.interpolate_property(self, "volume_db", volume_db, fade_volume, dur, transition_type, ease_types[EASE], 0)
	tween.start()
	play()
