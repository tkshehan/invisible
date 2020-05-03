extends Actor
class_name Decoy

var time_to_live = 3
var direction = Vector2.ZERO
var turns = 0

func get_dir():
	if turns < 1:
		return
	turns -= 1
	if time_to_live == 0:
		queue_free()
	time_to_live -= 1
	return direction

func player_moved():
	turns += 1
