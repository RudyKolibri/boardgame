extends KinematicBody2D
var hit = true
var check = false
var attack = false
var skip = false
signal attack
signal click
signal skip
var toggle_attacks = false
func _ready():
	#$AnimationPlayer.play("start")
	var _connect = connect("attack", $"..", "attackclick")
	var _connect2 = connect("click", $"..", "moveclick")
	var _connect3 = connect("skip", $"..", "skipclick")
	set_as_toplevel(true)
func _on_checkenemy_body_entered(body):
	if toggle_attacks == false and body != $"..":
		$Sprite.visible = false
		attack = true
func _on_checkenemy_body_exited(body):
	if toggle_attacks == false and body != $"..":
		$Sprite.visible = true
		attack = false
func kill():
	queue_free()
func get_attackstate():
	return attack
func toggle_attack():
	$Sprite.visible = false
	toggle_attacks = true
	attack = true
func _on_checkparent_body_entered(body):
	if toggle_attacks == true:
		if body == $"..":
			queue_free()

func _on_checktilemap_body_entered(body):
	if $"..".is_in_group("archer"):
		$skip.visible = false
		attack = true
	if attack == false and body == $"../../../TileMap":
		queue_free()


func _on_point_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if attack == true and skip == false:
			$AudioStreamPlayer2D.playing = true
			yield($AudioStreamPlayer2D, "finished")
			emit_signal("attack", self.global_position)
			
		elif skip == true:
			$AudioStreamPlayer2D.playing = true
			yield($AudioStreamPlayer2D, "finished")
			emit_signal("skip")
			
		else:
			$AudioStreamPlayer2D.playing = true
			yield($AudioStreamPlayer2D, "finished")
			emit_signal("click", self.global_position)
			
		queue_free()


func _on_skipper_body_entered(body):
	if body == $"..":
		skip = true
		$skip.visible = true
