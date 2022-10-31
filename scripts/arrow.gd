extends RigidBody2D

func start(side):
	set_linear_velocity(side * 4)


func _on_checkcol_body_entered(body):

	if body != $"..":
		print("hit " , str(body))
		queue_free()
