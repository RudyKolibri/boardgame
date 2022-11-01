extends Sprite
signal click
var my = false
func _input(event):
	if my == true:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)):
				emit_signal("click")
func myturn():
	my = true
func notmy():
	my = false
