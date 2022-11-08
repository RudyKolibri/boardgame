extends KinematicBody2D

export var health : int
func hit(damage, _idk = 0, _t = 0):
	self.health -= damage
	if health <= 0:
		$"../TileMap".make_bussy(self.global_position, false)
		queue_free()
func _ready():
	$"../TileMap".make_bussy(self.global_position, true)
