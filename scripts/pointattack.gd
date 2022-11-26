extends Sprite
signal attack
var off = Vector2(32, 32)
func _ready():
	var _connect = connect("attack", $"../..", "attackclick")
func _input(event):
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			var test = self.global_position - ($"../../../../Camera2D".global_position + event.position)
			if get_rect().has_point(-test):
				if $"..".get_attackstate() == true:
					emit_signal("attack", $"..".global_position)
					queue_free()
			else:
				$"..".queue_free()
