extends Node2D
var hit = true
var check = false
var attack = false
func _ready():
	set_as_toplevel(true)
func _on_checkenemy_body_entered(_body):
	$Sprite.visible = false
	attack = true
func _on_checkenemy_body_exited(_body):
	$Sprite.visible = true
	attack = false
func kill():
	queue_free()
func get_attackstate():
	return attack
