extends KinematicBody2D

export var health : int
func hit(damage, _idk = 0, _t = 0):
	self.health -= damage
	if health <= 0:
		queue_free()
