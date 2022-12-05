extends Camera2D
var _target_zoom: float = 1.0
const MIN_ZOOM: float = 0.5
const MAX_ZOOM: float = 1.0
const ZOOM_INCREMENT: float = 100.0
const ZOOM_RATE: float = 1.0
var zoomings = 0.0
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_RIGHT:
			position -= event.relative * zoom
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if self.zoom.x > 1.5:
					zoomings = 0.5
					zooms(zoomings)
			if event.button_index == BUTTON_WHEEL_DOWN:
				if self.zoom.x < 4:
					zoomings = -0.5
					zooms(zoomings)
func zooms(zooming) -> void:
	var zoom = self.zoom.x - zooming
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "zoom:x", zoom, 1)
	tween.tween_property(self, "zoom:y", zoom, 1)
func update_turns(turn):
	$Control/Control/turnsleft.text = str(turn)
