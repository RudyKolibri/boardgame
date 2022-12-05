extends Node2D
var has_been = false
func _ready():
	$Dialog.start()


func _on_dialog2toggler_body_entered(body):
	if body.is_in_group("player") and has_been == false:
		has_been = true
		$Dialog2.start()
		$Dialog.visible = false
