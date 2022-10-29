extends Node2D
var right = Vector2(8, 0)
var left = Vector2(-8, 0)
var up = Vector2(0, -8)
var down = Vector2(0, 8)
signal kill
export var point : PackedScene
func handle(x, y):
	var pos = self.position
	for i in x :
			self.position = self.position + right
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
			var check = pointer.checkcol()
			if check == true:
				break
	self.position = pos
	for i in x :
			self.position = self.position + left
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
			var check = pointer.checkcol()
			if check == true:
				break
	self.position = pos
	for i in y :
			self.position = self.position + up
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
			var check = pointer.checkcol()
			if check == true:
				break
	self.position = pos
	for i in y:
			self.position = self.position + down
			var pointer = point.instance() as Node2D
			get_parent().add_child(pointer)
			pointer.global_position = self.global_position
			connect("kill", pointer, "kill")
			var check = pointer.checkcol()
			if check == true:
				break
	self.position = pos
func _on_swordman_kill():
	emit_signal("kill")


func _on_archer_kill():
	emit_signal("kill")


