extends KinematicBody2D

export var health : int
func hit(damage):
	self.health -= damage
	if health <= 0:
		queue_free()
