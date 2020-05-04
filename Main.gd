extends Node

var level: Node2D

func _ready() -> void:
	var _err = globals.connect('stop_music', self, 'stop_music')
	globals.current_level = 1
	load_level()

func load_level():
	level = globals.get_level().instance()
	add_child(level)
	var _err =  level.connect("level_cleared", self, "on_level_finished")
	
func on_level_finished():
	globals.current_level += 1
	clear_level()
	load_level()

func clear_level():
	level.queue_free()

func restart_level():
	if globals.current_level == globals.max_level:
		return
	clear_level()
	yield(level, "tree_exited" )
	call_deferred("load_level")
	$Music.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_level()

func stop_music():
	$Music.stop()
