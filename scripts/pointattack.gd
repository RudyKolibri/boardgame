extends Sprite
signal attack
func _ready():
	connect("attack", $"../..", "attackclick")
func _input(event):
	if self.visible == true:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)):
				emit_signal("attack", self.global_position)
			else:
				$"..".queue_free()
