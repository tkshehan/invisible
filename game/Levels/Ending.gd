extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("Ending")

func ending_chime():
	globals.stop_music()
	$AudioStreamPlayer.fade_in()
