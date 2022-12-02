extends KinematicBody2D

onready var tween : Tween = $Tween

var ver = 2
var hor = 2
var ver_arrow = 4
var hor_arrow = 4
var chase = 0

signal kill
signal done
signal knockbackdone

var myturn = false
var chase_after = null
var sliding : = false
var is_chasing = false
var input = Vector2()

export var sliding_time : = 0.6
export var arrow : PackedScene
export var enemy : bool
export var health : int
func _ready():
	$"../../TileMap".make_bussy(self.global_position, true)
	if enemy:
		add_to_group("enemy")
		$Archer.visible = false
	else:
		add_to_group("player")
		$evelarcher.visible = false
func initialize():
	position = calculate_destination(Vector2())
func push(velocity: Vector2, times = 1) -> void:
	var time = 0
	var old_vel = velocity
	$RayCast2D.cast_to = old_vel * times
	var t = Timer.new()
	t.set_wait_time(0.05)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	if $RayCast2D.is_colliding():   
		var origin = $RayCast2D.global_transform.origin
		var collision_point = $RayCast2D.get_collision_point()
		var distance = origin.distance_to(collision_point)
		var times_tile = round(distance / 16) - 1
		if times_tile > times:
			time = times
		else:
			time = times_tile
	else:
		time = times
	var move_to = calculate_destination(old_vel.normalized() * time)
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
	$"../../TileMap".make_bussy(self.global_position, true)
	emit_signal("knockbackdone")
func calculate_destination(inputs):
	var tile_map_position = $"../../TileMap".world_to_map(global_position) + inputs
	return $"../../TileMap".map_to_world(tile_map_position)
func can_move(move_to: Vector2) -> bool:
	# Returns if the box can be moved to `move_to` without causing a collision
	var future_transform : = Transform2D(transform)
	future_transform.origin = move_to
	return not test_move(future_transform, Vector2())
func moveclick(pos):
	pos += Vector2(-4,-4)
	$"../../TileMap".make_bussy(self.global_position, false)
	$AudioStreamPlayer2D.playing = true
	$AnimationPlayer.play("move")
	var times = 0
	var move = self.global_position - pos
	if move.x != 0:
		times = move.x / 16
		if times < 0:
			times = - times
	if move.y != 0:
		times = move.y / 16
		if times < 0:
			times = - times
	push(-move, times)
	emit_signal("kill")
	myturn = false
	emit_signal("done")
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
	var get_side = pos - self.global_position
	if get_side.x != 0 and get_side.y != 0:
		get_side += Vector2(-4, -4)
	var side = Vector2()
	var arrower = arrow.instance() as Node2D
	add_child(arrower)
	arrower.global_position = self.global_position
	arrower.position.x += 8
	arrower.position.y += 8
	if get_side.x < 0:
		side = Vector2(-16,0)
		arrower.rotation_degrees = 180
	if get_side.x > 0:
		side =  Vector2(16,0)
		arrower.rotation_degrees = 0
	if get_side.y < 0:
		side =  Vector2(0,-16)
		arrower.rotation_degrees = 90
	if get_side.y > 0:
		side =  Vector2(0,16)
		arrower.rotation_degrees = -90
	arrower.start(side)
	myturn = false
	emit_signal("done")
func turn():
	if enemy != true:
		myturn = true
	else:
		var colliding = $attackcontrol.getcol()
		var t = Timer.new()
		t.set_wait_time(0.35)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		if colliding != Vector2.ZERO:
			attackclick(colliding)
			myturn = false
			emit_signal("done")
		elif is_chasing == true and is_instance_valid(chase_after):
			if not chase_after == null:
				var path = $path.chase(chase_after)
				if not path == null:
					var times = 1
					var pushing = (path * 16) - self.global_position
					if pushing.x / 16 > 0 or pushing.x / 16 < 0:
						times = pushing.x / 16
						if times > hor:
							times = hor
						if times < 0:
							times = - times
					if pushing.y / 16 > 0 or pushing.y / 16 < 0:
						times = pushing.y / 16
						if times > ver:
							times = ver
						if times < 0:
							times = - times
					$"../../TileMap".make_bussy(self.global_position, false)
					push(pushing, times)
			chase += 1
			if chase >= 5:
				is_chasing = false
				chase = 0
			myturn = false
			emit_signal("done")
		else:
			var path = $path.getnext()
			if not path == null:
				var times = 1
				var pushing = (path * 16) - self.global_position
				if pushing.x / 16 > 0 or pushing.x / 16 < 0:
					times = pushing.x / 16
					if times > hor:
						times = hor
					if times < 0:
						times = - times
				if pushing.y / 16 > 0 or pushing.y / 16 < 0:
					times = pushing.y / 16
					if times > ver:
						times = ver
					if times < 0:
						times = - times
				$"../../TileMap".make_bussy(self.global_position, false)
				push(pushing, times)
			myturn = false
			emit_signal("done")
func hit(damage, knockback = Vector2.ZERO, times = 1, parent = null):
	if not parent == null:
		is_chasing = true
		chase_after = parent
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
		if self.is_in_group("player"):
			self.remove_from_group("player")
		if self.is_in_group("enemy"):
			self.remove_from_group("enemy")
		if myturn == true:
			myturn = false
			emit_signal("done")
func _on_archer_input_event(_viewport, event, _shape_idx):
	if myturn == true:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			$archerhandler.handle(hor_arrow, ver_arrow)
			$inputhandler.handle(hor, ver)
func skipclick():
	emit_signal("kill")
	emit_signal("done")
	myturn = false
