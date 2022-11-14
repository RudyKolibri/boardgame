extends KinematicBody2D
var input = Vector2()
export var sliding_time : = 0.6
var sliding : = false
onready var tween : Tween = $Tween
export var attack : PackedScene
signal kill
var hor = 3
var ver = 3
var bodie
signal done
signal my_turn
signal notmy
signal selfdone
signal knockbackdone
var myturn = false
export var enemy : bool
export var health : int
func _ready():
	$"../../TileMap".make_bussy(self.global_position, true)
	var _connect = self.connect("my_turn", $Swordman, "myturn")
	var _connects = self.connect("notmy", $Swordman, "notmy")
	if enemy:
		add_to_group("enemy")
		$Swordman.visible = false
	else:
		add_to_group("player")
		$evelswordman.visible = false
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

func _on_Swordman_click():
	$inputhandler.handle(hor, ver)
func moveclick(pos):
	$"../../TileMap".make_bussy(self.global_position, false)
	$AnimationPlayer.play("move")
	$AudioStreamPlayer2D.playing = true
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
	emit_signal("done")
	emit_signal("notmy")
func attackclick(pos):
	$AudioStreamPlayer2D2.playing = true
	var get_side = self.global_position - pos
	emit_signal("kill")
	var attacker = attack.instance() as Node2D
	add_child(attacker)
	attacker.position = self.position - get_side
	emit_signal("done")
	emit_signal("selfdone")
	emit_signal("notmy")
func get_ver():
	return ver
func get_hor():
	return hor
func turn():
	if enemy != true:
		myturn = true
		emit_signal("my_turn")
	else:
		var colliding = $attackcontrol.getcol()
		var t = Timer.new()
		t.set_wait_time(0.35)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		if is_chasing == true:
			if not chase_after == null:
				var path =  $path.chase(chase_after)
				if not path == null:
					var times = 1
					print(path * 8)
					print(self.global_position)
					var pushing = (path * 8) - self.global_position
					print(pushing)
					if pushing.x / 8 > 0 or pushing.x / 8 < 0:
						times = pushing.x / 8
						if times > hor:
							times = hor
						if times < 0:
							times = - times
					#print(pushing.y / 8)
					if pushing.y / 8 > 0 or pushing.y / 8 < 0:
						times = pushing.y / 8
						if times > ver:
							times = ver
						if times < 0:
							times = - times
					#print(times)
					$"../../TileMap".make_bussy(self.global_position, false)
					push(pushing, times)
			emit_signal("done")
		if colliding == Vector2.ZERO:
			var path = $path.getnext()
			if not path == null:
				var times = 1
				print(path * 8)
				print(self.global_position)
				var pushing = (path * 8) - self.global_position
				print(pushing)
				if pushing.x / 8 > 0 or pushing.x / 8 < 0:
					times = pushing.x / 8
					if times > hor:
						times = hor
					if times < 0:
						times = - times
				#print(pushing.y / 8)
				if pushing.y / 8 > 0 or pushing.y / 8 < 0:
					times = pushing.y / 8
					if times > ver:
						times = ver
					if times < 0:
						times = - times
				#print(times)
				$"../../TileMap".make_bussy(self.global_position, false)
				push(pushing, times)
			emit_signal("done")
		else:
			attackclick(colliding)
			emit_signal("done")
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
