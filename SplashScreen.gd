extends Control

signal level_cleared

func _ready() -> void:
	var _err = $AnimationPlayer.play("Curtain")

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	emit_signal("level_cleared")
