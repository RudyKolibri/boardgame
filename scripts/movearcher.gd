extends KinematicBody2D
var input = Vector2()
export var sliding_time : = 0.6
var sliding : = false
onready var tween : Tween = $Tween
export var arrow : PackedScene
signal kill
var ver = 2
var hor = 2
var ver_arrow = 4
var hor_arrow = 4
signal done
signal knockbackdone
signal my_turn
signal notmy
var myturn = false
export var enemy : bool
export var health : int
func _ready():
	$"../../TileMap".make_bussy(self.global_position, true)
	var _connect = self.connect("my_turn", $Archer, "myturn")
	var _connects = self.connect("notmy", $Archer, "notmy")
	if enemy:
		add_to_group("enemy")
		$Archer.visible = false
	else:
		add_to_group("player")
		$evelarcher.visible = false
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
		$AudioStreamPlayer2D.playing = false
		emit_signal("knockbackdone")
		$"../../TileMap".make_bussy(self.global_position, true)
func calculate_destination(inputs):
	var tile_map_position = $"../../TileMap".world_to_map(global_position) + inputs
	return $"../../TileMap".map_to_world(tile_map_position)
func can_move(move_to: Vector2) -> bool:
	# Returns if the box can be moved to `move_to` without causing a collision
	var future_transform : = Transform2D(transform)
	future_transform.origin = move_to
	return not test_move(future_transform, Vector2())
func moveclick(pos):
	$"../TileMap".make_bussy(self.global_position, false)
	$AudioStreamPlayer2D.playing = true
	$AnimationPlayer.play("move")
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
	emit_signal("notmy")
	emit_signal("done")
func _on_Archer_click():
	$archerhandler.handle(hor_arrow, ver_arrow)
	$inputhandler.handle(hor, ver)
func get_ver():
	return ver
func get_hor():
	return hor
func get_ver_arrow():
	return ver_arrow
func get_hor_arrow():
	return hor_arrow
func attackclick(pos):
	$AudioStreamPlayer2D2.playing = true
	emit_signal("kill")
	var get_side = self.global_position - pos
	var side = Vector2()
	var arrower = arrow.instance() as Node2D
	add_child(arrower)
	arrower.global_position = self.global_position
	arrower.position.x += 4
	arrower.position.y += 4
	if get_side.x < 0:
		side = Vector2(8,0)
		arrower.rotation_degrees = 0
	if get_side.x > 0:
		side =  Vector2(-8,0)
		arrower.rotation_degrees = 180
	if get_side.y < 0:
		side =  Vector2(0,8)
		arrower.rotation_degrees = 90
	if get_side.y > 0:
		side =  Vector2(0,-8)
		arrower.rotation_degrees = -90
	arrower.start(side)
	emit_signal("notmy")
	emit_signal("done")
func turn():
	myturn = true
	emit_signal("my_turn")
func hit(damage, knockback = Vector2.ZERO, times = 1):
	$"../../TileMap".make_bussy(self.global_position, false)
	push(knockback, times)
	self.health -= damage
	$AnimationPlayer.play("move")
	$AudioStreamPlayer2D3.playing = true
	yield(self, "knockbackdone")
	if health <= 0:
		$AudioStreamPlayer2D4.play()
		yield($AudioStreamPlayer2D4, "finished")
		$"../../TileMap".make_bussy(self.global_position, false)
		queue_free()
		if myturn == true:
			emit_signal("done")
			emit_signal("notmy")
