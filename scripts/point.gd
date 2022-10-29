extends Node2D
var hit = true
func _ready():
	set_as_toplevel(true)
func _on_checkenemy_body_entered(_body):
	$Sprite.visible = false

func _on_checkenemy_body_exited(_body):
	$Sprite.visible = true
func kill():
	queue_free()

