extends Node2D
var astar = AStar2D.new()
var prev
var first
var active_dot
var index = 0
var offset = Vector2(4, 4)
onready var used_cells = $"../../../TileMap".get_used_cells_by_id(1)
onready var bussy_cell = []
var positionspath = []
func _ready():
	for point in get_child_count():
		positionspath.append(get_child(point).global_position)
	yield($"../../..", "start")
	bussy_cell = $"../../../TileMap".get_bussy()
	for cell in bussy_cell:
		if cell == $"../../../TileMap".world_to_map($"..".global_position):
			pass
		else:
			used_cells.erase(cell)
	for cell in used_cells:
		astar.add_point(id(cell), cell)
	for cell in used_cells:
		var buren = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, - 1)]
		for buur in buren:
			var next_cell = cell + buur
			if used_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell))
	for child in get_child_count():
		var pos = get_child(child).global_position
		var posworld = $"../../../TileMap".world_to_map(pos)
		if used_cells.has(posworld):
			if first == null:
				first = $".."
			if prev == null:
				prev = $".."
			var startpos = $"../../../TileMap".world_to_map(prev.global_position)
			var _array = path(id(startpos), id(posworld))
			prev = get_child(child)
	var pos = first.global_position
	var posworld = $"../../../TileMap".world_to_map(pos)
	var startpos = $"../../../TileMap".world_to_map(prev.global_position)
	path(id(startpos),id(posworld))
func path(start, end):
	var path = astar.get_point_path(start, end)
	for p in path:
		$"../../../Line2D".add_point(p * 8 + offset)
	return path
func id(point):
	var a = point.x
	var b = point.y
	return (a + b)  * (a + b + 1) / 2 + b
func getnext():
	var array
	if positionspath[index] == $"..".global_position:
		active_dot = get_child(index)
		index = (active_dot.get_index() + 1) % get_child_count()
	astar.clear()
	$"../../../Line2D".clear_points()
	used_cells = $"../../../TileMap".get_used_cells_by_id(1)
	bussy_cell = $"../../../TileMap".get_bussy()
	for cell in bussy_cell:
		if not cell == $"../../../TileMap".world_to_map($"..".global_position):
			used_cells.erase(cell)
	for cell in used_cells:
		astar.add_point(id(cell), cell)
	for cell in used_cells:
		var buren = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, - 1)]
		for buur in buren:
			var next_cell = cell + buur
			if used_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell))
	var pos = positionspath[index]
	var posworld = $"../../../TileMap".world_to_map(pos)
	if used_cells.has(posworld):
		var startpos = $"../../../TileMap".world_to_map($"..".global_position)
		array = path(id(startpos), id(posworld))
		#here
		array.remove(0)
		for i in array.size():
			if array.size() >= 3:
				if array[0].y - array[1].y == array[1].y - array[2].y or array[0].x - array[1].x == array[1].x - array[2].x:
					 array.remove(1)
		return array[1]
