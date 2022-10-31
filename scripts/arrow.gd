extends RigidBody2D

func start(side):
	set_linear_velocity(side * 4)


func _on_checkcol_body_entered(body):
	print($"..".get_groups())
	print(body.get_groups())
	if $"..".get_groups() != body.get_groups():
		if body != $"..":
			print("hit " , str(body))
			queue_free()
	else:
		print("same group")
