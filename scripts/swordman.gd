extends KinematicBody2D
var input = Vector2()
export var sliding_time : = 0.3
var sliding : = false
onready var tween : Tween = $Tween
signal kill
func initialize():
	position = calculate_destination(Vector2())
	
func push(velocity: Vector2, times = 1) -> void:
	var move_to = calculate_destination(velocity.normalized() * times)
	if can_move(move_to):
		var _bla = tween.interpolate_property(self, 
			"global_position",
			global_position,
			move_to,
			sliding_time,
			Tween.TRANS_CUBIC,
			Tween.EASE_OUT)
		var _bla2 = tween.start()
		sliding = true
		yield(tween, "tween_completed")
		sliding = false
		
func calculate_destination(input):
	var tile_map_position = $"..".world_to_map(global_position) + input
	return $"..".map_to_world(tile_map_position)
	
func can_move(move_to: Vector2) -> bool:
	# Returns if the box can be moved to `move_to` without causing a collision
	var future_transform : = Transform2D(transform)
	future_transform.origin = move_to
	return not test_move(future_transform, Vector2())

func _on_Swordman_click():
	$inputhandler.handle(2, 2)
func moveclick(pos):
	var times = 0
	var move = self.global_position - pos
	if move.x != 0:
		times = move.x / 8
		if times < 0:
			times = - times
	if move.y != 0:
		times = move.y / 8
		if times < 0:
			times = - times
	push(-move, times)
	emit_signal("kill")
func attackclick(_pos):
	print("kill")
