extends Node2D
export var damage : int
func _ready():
	set_as_toplevel(true)
	$AnimationPlayer.play("attack")
func _on_attack_body_entered(body):
	if $"..".get_groups() != body.get_groups():
		body.hit(damage)
	else:
		pass
func kill():
	queue_free()
