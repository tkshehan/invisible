extends Node

signal stop_music
signal start_music(duration)

var level_paths = [
	"res://game/Title.tscn",
	"res://game/Levels/Entrance.tscn",
	"res://game/Levels/WrapAround.tscn",
	"res://game/Levels/LoneSentry.tscn",
	"res://game/Levels/NoBreaks.tscn",
	"res://game/Levels/WaitForIt.tscn",
	"res://game/Levels/StandHere.tscn",
	"res://game/Levels/Collusion.tscn",
	"res://game/Levels/ShakeItOff.tscn",
	"res://game/Levels/Final.tscn",
	"res://game/Levels/Ending.tscn"
]

var max_level = level_paths.size() - 1
var current_level = 0
var nav

func get_level():
	return load(level_paths[current_level])

func stop_music():
	emit_signal("stop_music")

func start_music(duration):
	emit_signal("start_music", duration)
