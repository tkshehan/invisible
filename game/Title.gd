extends Control

signal level_cleared

var starting = false

func _ready() -> void:
	connect("tree_exiting", self, "start_music")
	$AnimationPlayer.play("Curtain")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Curtain Close":
		emit_signal("level_cleared")

func _input(event: InputEvent) -> void:
	if starting:
		return
	if event.is_action_pressed("cloak"):
		starting = true
		$AudioStreamPlayer.play()
		globals.stop_music()
		$AnimationPlayer.play("Curtain Close")

func start_music():
	globals.start_music(0.2)
