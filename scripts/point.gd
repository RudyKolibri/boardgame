extends Node2D
var hit = true
var check = false
func _ready():
	set_as_toplevel(true)
func _on_checkenemy_body_entered(_body):
	$Sprite.visible = false

func _on_checkenemy_body_exited(_body):
	$Sprite.visible = true
func kill():
	queue_free()
func checkcol():
	return $RayCast2D.is_colliding()
