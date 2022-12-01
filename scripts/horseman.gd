extends KinematicBody2D
onready var tween : Tween = $Tween

var hor = 5
var ver = 5
var chase = 0 

signal done
signal knockbackdone
signal kill

var input = Vector2()
var myturn = false
var chase_after = null
var is_chasing = false
var bodie
var sliding : = false

export var sliding_time : = 0.6
export var enemy : bool
export var health : int
export var damage : int

func _ready():
	$"../../TileMap".make_bussy(self.global_position, true)
	if enemy:
		add_to_group("enemy")
		$normal.visible = false
	else:
		add_to_group("player")
		$evel.visible = false
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
	$AnimationPlayer.play("move")
	$AudioStreamPlayer2D.playing = true
	var times = 0
	var move = self.global_position - pos
	if (move.x) != 0:
		times = move.x / 16
		if move.x < 0:
			$links/CollisionShape2D.disabled = false
			$rechts/CollisionShape2D.disabled = false
		if times < 0:
			times = - times
	if (move.y) != 0:
		times = move.y / 16
		if move.y > 0:
			$omhoog/CollisionShape2D.disabled = false
		elif move.y < 0:
			$beneden/CollisionShape2D.disabled = false
		if times < 0:
			times = - times
	else:
		$beneden/CollisionShape2D.disabled = false
		$omhoog/CollisionShape2D.disabled = false
		$links/CollisionShape2D.disabled = false
		$rechts/CollisionShape2D.disabled = false
	push(-move, times)
	emit_signal("kill")
	myturn = false
	yield(self, "knockbackdone")
	$omhoog/CollisionShape2D.disabled = true
	$beneden/CollisionShape2D.disabled = true
	$links/CollisionShape2D.disabled = true
	$rechts/CollisionShape2D.disabled = true
	emit_signal("done")
func get_ver():
	return ver
func get_hor():
	return hor
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
			#attackclick(colliding)
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
					if times < 0:
						times = - times
					if times > hor:
						times = hor
				if pushing.y / 16 > 0 or pushing.y / 16 < 0:
					times = pushing.y / 16
					if times < 0:
						times = - times
					if times > ver:
						times = ver
				$"../../TileMap".make_bussy(self.global_position, false)
				push(pushing, times)
			myturn = false
			emit_signal("done")
func hit(damages, knockback = Vector2.ZERO, times = 1, parent = null):
	if not parent == null:
		chase_after = parent
		is_chasing = true
	$"../../TileMap".make_bussy(self.global_position, false)
	push(knockback, times)
	self.health -= damages
	$AnimationPlayer.play("move")
	$AudioStreamPlayer2D3.playing = true
	yield(self, "knockbackdone")
	if health <= 0:
		$AudioStreamPlayer2D4.play()
		yield($AudioStreamPlayer2D4, "finished")
		$"../../TileMap".make_bussy(self.global_position, false)
		if self.is_in_group("player"):
			self.remove_from_group("player")
		if self.is_in_group("enemy"):
			self.remove_from_group("enemy")
		queue_free()
		if myturn == true:
			myturn = false
			emit_signal("done")
func skipclick():
	myturn = false
	moveclick(self.global_position)
func _on_horseman_input_event(_viewport, event,_shape_idx):
	if myturn == true:
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			$inputhandler.handle(hor, ver, 1)
func attack(body):
	if body.is_in_group("tilemap"):
		pass
	elif self.is_in_group("enemy") != body.is_in_group("enemy") or body.is_in_group("wall"):
		body.hit(damage, Vector2.ZERO,  1, self)
	else:
		pass
