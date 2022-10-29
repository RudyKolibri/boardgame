extends Sprite
signal click
func _ready():
	var _connect =connect("click", $"../..", "moveclick")
func _input(event):
	if self.visible:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			if get_rect().has_point(to_local(event.position)):
				emit_signal("click", self.global_position)
				$"..".hitter()
