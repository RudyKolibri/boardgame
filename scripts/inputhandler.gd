extends Node2D
var right = Vector2(8, 0)
var left = Vector2(-8, 0)
var up = Vector2(0, -8)
var down = Vector2(0, 8)
signal kill
export var point : PackedScene
func _ready():
	var ver = $"..".get_ver()
	var hor = $"..".get_hor()
	$recht.cast_to = right * hor
	$links.cast_to = left * hor
	$up.cast_to = up * ver
	$down.cast_to = down * ver
func handle(x, y):
	var recht = x
	var links = x
	var omhoog = y
	var beneden = y
	var pos = self.position
	$recht.cast_to = right * x
	$links.cast_to = left * x
	$up.cast_to = up * x
	$down.cast_to = down * x
	if $recht.is_colliding():   
		var origin = $recht.global_transform.origin
		var collision_point = $recht.get_collision_point()
		var distance = origin.distance_to(collision_point)
		recht = round(distance / 8)
	if $links.is_colliding():   
		var origin = $links.global_transform.origin
		var collision_point = $links.get_collision_point()
		var distance = origin.distance_to(collision_point)
		links = round(distance / 8)
	if $up.is_colliding():   
		var origin = $up.global_transform.origin
		var collision_point = $up.get_collision_point()
		var distance = origin.distance_to(collision_point)
		omhoog = round(distance / 8)
	if $down.is_colliding():   
		var origin = $down.global_transform.origin
		var collision_point = $down.get_collision_point()
		var distance = origin.distance_to(collision_point)
		beneden = round(distance / 8)
	for i in recht :
			self.position = self.position + right
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
	self.position = pos
	for i in links :
			self.position = self.position + left
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
	self.position = pos
	for i in omhoog :
			self.position = self.position + up
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
	self.position = pos
	for i in beneden:
			self.position = self.position + down
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
	self.position = pos
func _on_swordman_kill():
	emit_signal("kill")


func _on_archer_kill():
	emit_signal("kill")


