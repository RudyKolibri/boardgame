extends Node2D

func _ready():
	set_as_toplevel(true)
	$AnimationPlayer.play("attack")
func _on_attack_body_entered(body):
	print($"..")
	print($"..".get_groups())
	print(body.get_groups())
	if $"..".get_groups() != body.get_groups():
		print("hit " , str(body))
	else:
		print("same group")
func kill():
	queue_free()
