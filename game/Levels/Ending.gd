extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("Ending")

func ending_chime():
	globals.stop_music()
	$AudioStreamPlayer.fade_in()

func _on_github_pressed() -> void:
	OS.shell_open("https://github.com/tkshehan")


func _on_soundcloud_pressed() -> void:
	OS.shell_open("https://soundcloud.com/horofosho")
