extends Node2D

func look(direction):
	match direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.UP:
			rotation_degrees = 180
		Vector2.RIGHT:
			rotation_degrees = 270
			
