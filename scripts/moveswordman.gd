extends Sprite
signal click
var off = Vector2(32, 32)
func _ready():
	var _connect = connect("click", $"../..", "moveclick")
func _input(event):
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			var get_zoom = $"../../../../Camera2D".get_zoom()
			var test = $"..".position - $"../../../../Camera2D".position - (event.position * get_zoom)
			if get_rect().has_point(-test):
				if $"..".get_attackstate() == false:
					emit_signal("click", self.global_position)
					queue_free()
			else:
				$"..".queue_free()
