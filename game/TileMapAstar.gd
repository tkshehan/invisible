extends TileMap

onready var astar = AStar.new()
onready var obstacles = get_used_cells_by_id(0)

func _ready():
	print(get_cell_autotile_coord(0,0))
	var cells = get_used_cells()
	for cell in cells:
		astar.add_point(astar.get_available_point_id(), Vector3(cell.x, cell.y, 0))
	connect_points(cells)
	
			
func connect_points(cells):
	for cell in cells:
		if cell in obstacles:
			continue
		var cell_index = astar.get_closest_point(Vector3(cell.x, cell.y, 0))
		var points_relative = PoolVector3Array([
			Vector3(cell.x + 1, cell.y, 0),
			Vector3(cell.x - 1, cell.y, 0),
			Vector3(cell.x, cell.y + 1, 0),
			Vector3(cell.x, cell.y - 1, 0)])
		for point in points_relative:
			var point_index = astar.get_closest_point(point)
			if point_index == cell_index:
				continue
			if not astar.has_point(point_index):
				continue
			if point in obstacles:
				continue
			astar.connect_points(cell_index, point_index, false)
	
func find_simple_path(start, end):
	start = world_to_map(start)
	end = world_to_map(end)
	var start_index = astar.get_closest_point(Vector3(start.x, start.y, 0))
	var end_index = astar.get_closest_point(Vector3(end.x, end.y, 0))
	var points = astar.get_point_path(start_index, end_index)
	var points2d = []
	for point in points:
		points2d.append(Vector2(point.x, point.y))
	return points2d


## This is a variation of the method above
## It connects cells horizontally, vertically AND diagonally
#func astar_connect_walkable_cells_diagonal(points_array):
#	for point in points_array:
#		var point_index = calculate_point_index(point)
#		for local_y in range(3):
#			for local_x in range(3):
#				var point_relative = Vector2(point.x + local_x - 1, point.y + local_y - 1)
#				var point_relative_index = calculate_point_index(point_relative)
#
#				if point_relative == point or is_outside_map_bounds(point_relative):
#					continue
#				if not astar_node.has_point(point_relative_index):
#					continue
#				astar_node.connect_points(point_index, point_relative_index, true)
