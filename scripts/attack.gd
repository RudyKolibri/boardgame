extends Node2D
export var damage : int
func _ready():
	set_as_toplevel(true)
	$AnimationPlayer.play("attack")
func _on_attack_body_entered(body):
	if body == $"../../../TileMap":
		pass
	elif $"..".is_in_group("enemy") != body.is_in_group("enemy") or body.is_in_group("wall"):
		body.hit(damage, Vector2.ZERO,  1, $"..")
	else:
		pass
func kill():
	queue_free()
