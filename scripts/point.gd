extends Node2D
func _ready():
	set_as_toplevel(true)
func _on_checkenemy_body_entered(body):
	$Sprite.visible = false

func _on_checkenemy_body_exited(body):
	$Sprite.visible = true
func kill():
	queue_free()
