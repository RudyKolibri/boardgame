extends Camera2D
var _target_zoom: float = 1.0
const MIN_ZOOM: float = 0.5
const MAX_ZOOM: float = 1.0
const ZOOM_INCREMENT: float = 100.0
const ZOOM_RATE: float = 1.0
var zoomings = 0
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_MIDDLE:
			position -= event.relative * zoom
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				zoomings += 0.2
				zoom(zoomings)
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoomings -= 0.22
				zoom(zoomings)
func zoom(zooming) -> void:
	var zoom
	if zooming > 0:
		zoom = zooming
		if zoom > 1:
			zoom = 1
	if zooming < 0:
		zoom = zooming
		if zoom < -1:
			zoom = -1
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "zoom:x", zoom, MAX_ZOOM)
	tween.tween_property(self, "zoom:y", zoom, MAX_ZOOM)

