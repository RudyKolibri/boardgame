extends RigidBody2D
export var damage : int
func start(side):
	set_linear_velocity(side * 8)


func _on_checkcol_body_entered(body):
	print($"..".get_groups())
	print(body.get_groups())
	if $"..".get_groups() != body.get_groups():
		if body != $"..":
			print("hit " , str(body))
			queue_free()
			body.hit(damage)
	else:
		print("same group")
