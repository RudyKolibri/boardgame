extends Node2D
var right = Vector2(8, 0)
var left = Vector2(-8, 0)
var up = Vector2(0, -8)
var down = Vector2(0, 8)
signal kill
export var point : PackedScene
func _ready():
	$recht.add_exception($"..")
	$links.add_exception($"..")
	$omhoog.add_exception($"..")
	$omlaag.add_exception($"..")
	var ver_arrow = $"..".get_ver_arrow()
	var hor_arrow = $"..".get_hor_arrow()
	$recht.cast_to = right * hor_arrow
	$links.cast_to = left * hor_arrow
	$omhoog.cast_to = up * ver_arrow
	$omlaag.cast_to = down * ver_arrow
func handle(x, y):
	var recht = x -1
	var links = x -1
	var omhoog = y -1
	var beneden = y -1
	var pos = self.position
	$recht.cast_to = right * x
	$links.cast_to = left * x
	$omhoog.cast_to = up * x
	$omlaag.cast_to = down * x
	if $recht.is_colliding():   
		var origin = $recht.global_transform.origin
		var collision_point = $recht.get_collision_point()
		var distance = origin.distance_to(collision_point)
		print(origin.distance_to(collision_point))
		recht = round(distance / 8)
	if $links.is_colliding():   
		var origin = $links.global_transform.origin
		var collision_point = $links.get_collision_point()
		var distance = origin.distance_to(collision_point)
		links = round(distance / 8) - 1
	if $omhoog.is_colliding():   
		var origin = $omhoog.global_transform.origin
		var collision_point = $omhoog.get_collision_point()
		var distance = origin.distance_to(collision_point)
		omhoog = round(distance / 8)
	if $omlaag.is_colliding():   
		var origin = $omlaag.global_transform.origin
		var collision_point = $omlaag.get_collision_point()
		var distance = origin.distance_to(collision_point)
		beneden = round(distance / 8)
	self.position += right
	for i in recht :
			self.position = self.position + right
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			pointer.toggle_attack()
			var _connect = connect("kill", pointer, "kill")
	self.position = pos
	self.position += left
	for i in links :
			self.position = self.position + left
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			pointer.toggle_attack()
			var _connect = connect("kill", pointer, "kill")
	self.position = pos
	self.position += up
	for i in omhoog :
			self.position = self.position + up
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			pointer.toggle_attack()
			var _connect = connect("kill", pointer, "kill")
	self.position = pos
	self.position += down
	for i in beneden:
			self.position = self.position + down
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			pointer.toggle_attack()
			var _connect = connect("kill", pointer, "kill")
	self.position = pos
func _on_archer_kill():
	emit_signal("kill")
