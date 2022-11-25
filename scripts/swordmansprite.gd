extends Sprite
signal click
var my = false
var off = Vector2(32, 32)
func _input(event):
	if my == true:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			var get_zoom = $"../../../Camera2D".get_zoom()
			var test = $"..".position - $"../../../Camera2D".position - (event.position * get_zoom)
			if get_rect().has_point(-test):
				emit_signal("click")
func myturn():
	my = true
func notmy():
	my = false
