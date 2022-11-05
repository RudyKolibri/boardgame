extends RigidBody2D
export var damage : int
func start(side):
	set_linear_velocity(side * 8)


func _on_checkcol_body_entered(body):
	if $"..".is_in_group("enemy") != body.is_in_group("enemy") or body.is_in_group("wall"):
		if body != $"..":
			queue_free()
			body.hit(damage)
	else:
		print("same")
