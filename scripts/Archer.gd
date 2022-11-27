extends Sprite
signal click
var my = false
var off = Vector2(32, 32)
func _input(event):
	if my == true:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			var test = ($"../../../Camera2D".global_position + event.position) - $"..".global_position
			if get_rect().has_point(test):
				emit_signal("click")
func myturn():
	my = true
func notmy():
	my = false
