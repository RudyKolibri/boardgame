extends Node2D
var astar = AStar2D.new()
var prev
var first
var offset = Vector2(4, 4)
onready var used_cells = $"..".get_used_cells()
func _ready():
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
		var posworld = $"..".world_to_map(pos)
		if used_cells.has(posworld):
			if first == null:
				first = get_child(child) #will be the piece
			if prev == null:
				prev = get_child(child) #will be the piece
			var startpos = $"..".world_to_map(prev.global_position)
			path(startpos, posworld)
			prev = get_child(child)
	var pos = first.global_position
	var posworld = $"..".world_to_map(pos)
	var startpos = $"..".world_to_map(prev.global_position)
	path(startpos, posworld)

func path(start, end):
	var path = astar.get_point_path(id(start), id(end))
	print(path)
	for p in path:
		$"../Line2D".add_point(p * 8 + offset)

func id(point):
	var a = point.x
	var b = point.y
	return (a + b)  * (a + b + 1) / 2 + b
