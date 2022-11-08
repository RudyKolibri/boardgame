extends TileMap
onready var tilemap = self
var bussy = []
func setting(pos, tile = 0):
	tilemap.set_cellv(world_to_map(pos), tile)
func get_bussy():
	return bussy
func make_bussy(pos, bol):
	if bol == true:
		bussy.append(world_to_map(pos))
	else:
		var find = bussy.find(world_to_map(pos))
		bussy.remove(find)
