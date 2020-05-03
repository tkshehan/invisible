extends Node


var level_paths = [
	"res://game/Level.tscn",
	"res://game/Level.tscn"
]

var current_level = 1
var nav

func get_level(num):
	current_level = num
	return load(level_paths[num])
