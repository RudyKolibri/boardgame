extends Node2D

var has_been = false

func _on_dialog_toggle_body_entered(body):
	if body.is_in_group("player") and has_been == false:
		has_been = true
		$Dialog.start()
