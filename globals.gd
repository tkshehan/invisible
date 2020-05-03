extends Node


var level_paths = [
	"res://game/Level.tscn",
	"res://game/Levels/Entrance.tscn",
	"res://game/Levels/WrapAround.tscn",
	"res://game/Levels/LoneSentry.tscn",
	"res://game/Levels/WaitForIt.tscn"
]

var max_level = level_paths.size() - 1
var current_level = 1
var nav

func get_level():
	return load(level_paths[current_level])
