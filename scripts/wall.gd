extends KinematicBody2D

export var health : int
func hit(damage, _idk = 0, _t = 0):
	self.health -= damage
	if health <= 0:
		$"../TileMap".setting(self.position, 1)
		queue_free()
func _ready():
	$"../TileMap".setting(self.position, 3)
