extends TileMap
onready var tilemap = self
func setting(pos, tile = 0):
	print()
	tilemap.set_cellv(world_to_map(pos), tile)
