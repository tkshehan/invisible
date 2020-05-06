extends Node

var level

func _ready() -> void:
	$Music.fade_in(0.1)
	var _err = globals.connect('stop_music', self, 'stop_music')
	globals.current_level = 0
	load_level()

func load_level():
	level = globals.get_level().instance()
	add_child(level)
	if !is_last_level():
		var _err =  level.connect("level_cleared", self, "on_level_finished")
	
func on_level_finished():
	globals.current_level += 1
	if is_last_level():
		$Music.EASE = "EASE_IN"
		stop_music(3)
		get_tree().paused = true
		yield($Music/Tween, "tween_completed")
	clear_level()
	load_level()

func clear_level():
	level.queue_free()

func restart_level():
	if globals.current_level == globals.max_level:
		return
	if globals.current_level == 0:
		return
	clear_level()
	yield(level, "tree_exited" )
	call_deferred("load_level")
	$Music.fade_in(0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_level()

func stop_music(duration = -1):
	if duration == -1:
		$Music.fade_out()
	else:
		 $Music.fade_out(duration)

func is_last_level():
	return globals.current_level == globals.max_level
