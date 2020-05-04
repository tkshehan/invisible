extends Node

var level: Node2D

func _ready() -> void:
	globals.current_level = 4
	load_level()

func load_level():
	level = globals.get_level().instance()
	add_child(level)
	level.connect("level_cleared", self, "on_level_finished")
	
func on_level_finished():
	if globals.current_level >= globals.max_level:
		$Popup.popup()
		return
	globals.current_level += 1
	clear_level()
	load_level()

func clear_level():
	level.queue_free()

func restart_level():
	clear_level()
	load_level()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_level()
