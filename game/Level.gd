extends Node2D

var last_enemy
onready var decoy = load("res://game/actors/Decoy.tscn")
signal level_cleared

func _ready():
	globals.nav = $TileMap
	$Player.connect("moved", self, '_on_player_moved')
	$Player.connect("cloaked", self, '_on_player_cloaked')
	$Player.connect("uncloaked", self, '_on_player_uncloaked')
	for body in get_tree().get_nodes_in_group("ai"):
		if body is Enemy:
			body.connect("killed_player", self, "kill_player")
			body.connect("collision", self, "robot_collision")
	
# Draws a grid
func _draw():
	var begin = -64
	var end_y = 600
	var end_x = 1000
	var color = Color8(128,140, 123,50)
	for x in range(begin, end_x, 32):
		draw_line(Vector2(x, begin), Vector2(x, end_y), color)
	for y in range(begin, end_y, 32):
		draw_line(Vector2(begin, y), Vector2(end_x, y), color)

func _on_player_moved():
	var position = $TileMap.world_to_map($Player.position)
	if $TileMap.get_cell(position.x, position.y) == 2:
		on_player_win()
	
	get_tree().call_group("ai", "player_moved")
	
func _on_player_cloaked():
	var _decoy = decoy.instance()
	_decoy.position = $Player.position - Vector2(1,1)
	add_child(_decoy)
	if $Player.cloaks_left == 0:
		$HUD.no_cloak()
	
func _on_player_uncloaked():
	pass

func kill_player():
	$Death_Popup.visible = true
	$Player.kill()
	globals.stop_music()

func on_player_win():
	emit_signal("level_cleared")

func robot_collision(body1, body2):
	if body1 is Enemy and body2 is Enemy:
		body1.queue_free()
		body2.queue_free()
