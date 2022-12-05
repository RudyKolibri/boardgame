extends CanvasLayer

func change_scene(target : String, camera = Vector2(1,1)) -> void:
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	var _return = get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("fade")
	yield($AnimationPlayer, "animation_finished")
	get_tree().current_scene.get_child(0).change_camera(camera)
