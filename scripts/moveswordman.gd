extends Sprite
signal click
func _ready():
	connect("click", $"../..", "moveclick")
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			emit_signal("click", self.global_position)
		else:
			$"..".queue_free()
