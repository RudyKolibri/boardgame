extends RigidBody2D
export var damage : int
var knockback
var times = 2
func start(side):
	knockback = side
	set_linear_velocity(side * 8)


func _on_checkcol_body_entered(body):
	if $"..".is_in_group("enemy") != body.is_in_group("enemy") or body.is_in_group("wall"):
		if body != $"..":
			queue_free()
			body.hit(damage, knockback, times)
	else:
		print("same")
