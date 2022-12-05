extends Node2D
var astar = AStar2D.new()
var prev
var first
var active_dot
var index = 0
var wr
var offset = Vector2(8, 8)
onready var used_cells = $"../../../TileMap".get_used_cells_by_id(0) + $"../../../TileMap".get_used_cells_by_id(2)
onready var bussy_cell = []
var positionspath = []
func _ready():
	var randomiser = []
	var nonshuffle = []
	for child in get_child_count():
		randomiser.append(child)
		nonshuffle.append(child)
	randomize()
	randomiser.shuffle()
	for child in randomiser:
		self.move_child(get_child(nonshuffle[0]), child)
		nonshuffle.erase(0)
	for point in get_child_count():
		positionspath.append(get_child(point).global_position)
	yield($"../../..", "start")
	bussy_cell = $"../../../TileMap".get_bussy()
	for cell in used_cells:
		if bussy_cell.has(cell) and not cell == $"../../../TileMap".world_to_map($"..".global_position):
			astar.add_point(id(cell), cell, 100)
		else:
			astar.add_point(id(cell), cell, 1)
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
		$"../../../Line2D".add_point(p * 16 + offset)
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
	used_cells = $"../../../TileMap".get_used_cells_by_id(0) + $"../../../TileMap".get_used_cells_by_id(2)
	bussy_cell = $"../../../TileMap".get_bussy()
	for cell in used_cells:
		if bussy_cell.has(cell) and not cell == $"../../../TileMap".world_to_map($"..".global_position):
			astar.add_point(id(cell), cell, 100)
		else:
			astar.add_point(id(cell), cell, 1)
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
		for i in array.size():
			if array.size() >= 3:
				if array[0].y - array[1].y == array[1].y - array[2].y or array[0].x - array[1].x == array[1].x - array[2].x:
					 array.remove(0)
		if array.size() >= 1:
			return array[1]
		else:
			return
func chase(parent):
	var array
	$"../../../TileMap".make_bussy(self.global_position, false)
	$"../../../TileMap".make_bussy(parent.global_position, false)
	astar.clear()
	$"../../../Line2D".clear_points()
	used_cells = $"../../../TileMap".get_used_cells_by_id(0)+ $"../../../TileMap".get_used_cells_by_id(2)
	bussy_cell = $"../../../TileMap".get_bussy()
	for cell in used_cells:
		if bussy_cell.has(cell) and not cell == $"../../../TileMap".world_to_map($"..".global_position):
			astar.add_point(id(cell), cell, 100)
		else:
			astar.add_point(id(cell), cell, 1)
	for cell in used_cells:
		var buren = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, - 1)]
		for buur in buren:
			var next_cell = cell + buur
			if used_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell))
	var pos = $"../../../TileMap".world_to_map(parent.global_position)
	if used_cells.has(pos):
		var startpos = $"../../../TileMap".world_to_map($"..".global_position)
		array = path(id(startpos), id(pos))
		for i in array.size():
			if array.size() >= 3:
				if array[0].y - array[1].y == array[1].y - array[2].y or array[0].x - array[1].x == array[1].x - array[2].x:
					 array.remove(0)
		$"../../../TileMap".make_bussy(pos, true)
		if array.size() > 1:
			return array[1]
		elif array.size() == 1:
			return array[0]
	$"../../../TileMap".make_bussy(self.global_position, true)
