extends Node2D

signal level_cleared

func _ready() -> void:
	$AnimationPlayer.play("Ending")

func ending_chime():
	globals.stop_music()
	$AudioStreamPlayer2D.play()
