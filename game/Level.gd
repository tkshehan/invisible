extends Node2D

var last_enemy
onready var decoy = load("res://game/actors/Decoy.tscn")

func _ready():
	globals.nav = $TileMap
	$Player.connect("moved", self, '_on_player_moved')
	$Player.connect("cloaked", self, '_on_player_cloaked')
	$Player.connect("uncloaked", self, '_on_player_uncloaked')

func _draw():
	var begin = -64
	var end_y = 600
	var end_x = 1000
	var color = Color8(0,0,0,50)
	for x in range(begin, end_x, 32):
		draw_line(Vector2(x, begin), Vector2(x, end_y), color)
	for y in range(begin, end_y, 32):
		draw_line(Vector2(begin, y), Vector2(end_x, y), color)

func _on_player_moved():
	get_tree().call_group("ai", "player_moved")
	
func _on_player_cloaked():
#	get_tree().call_group("ai", "player_cloaked")
	var _decoy = decoy.instance()
	_decoy.position = $Player.position - Vector2(1,1)
	add_child(_decoy)
	
func _on_player_uncloaked():
	pass # remove decoy
