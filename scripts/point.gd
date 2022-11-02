extends Node2D
var hit = true
var check = false
var attack = false
var toggle_attacks = false
func _ready():
	set_as_toplevel(true)
func _on_checkenemy_body_entered(_body):
	if toggle_attacks == false:
		$Sprite.visible = false
		attack = true
func _on_checkenemy_body_exited(_body):
	if toggle_attacks == false:
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
		$Sprite.visible = false
		attack = true
	if attack == false:
		queue_free()
