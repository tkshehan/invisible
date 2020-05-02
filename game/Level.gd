extends Node2D

func _ready():
	globals.nav = $TileMap

func _draw():
	var begin = -64
	var end_y = 600
	var end_x = 1000
	var color = Color8(0,0,0,50)
	for x in range(begin, end_x, 32):
		draw_line(Vector2(x, begin), Vector2(x, end_y), color)
	for y in range(begin, end_y, 32):
		draw_line(Vector2(begin, y), Vector2(end_x, y), color)

