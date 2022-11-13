extends Node2D
func _ready():
	$RayCast2D.add_exception($"..")
	$RayCast2D2.add_exception($"..")
	$RayCast2D3.add_exception($"..")
	$RayCast2D4.add_exception($"..")
func getcol():
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("enemy") == false and $RayCast2D.get_collider().is_in_group("body"):
			var origin = $RayCast2D.global_transform.origin
			var collision_point = $RayCast2D.get_collision_point()
			var distance = origin.distance_to(collision_point)
			var idk = round(distance / 8)
			for i in idk:
				self.global_position += Vector2(8, 0)
			var glob = self.global_position
			self.global_position = $"..".global_position
			return glob
	if $RayCast2D2.is_colliding():
		if $RayCast2D2.get_collider().is_in_group("enemy") == false and $RayCast2D2.get_collider().is_in_group("body"):
			var origin = $RayCast2D2.global_transform.origin
			var collision_point = $RayCast2D2.get_collision_point()
			var distance = origin.distance_to(collision_point)
			var idk = round(distance / 8)
			for i in idk:
				self.global_position += Vector2(0, 8)
			var glob = self.global_position
			self.global_position = $"..".global_position
			return glob
	if $RayCast2D3.is_colliding():
		if $RayCast2D3.get_collider().is_in_group("enemy") == false and $RayCast2D3.get_collider().is_in_group("body"):
			var origin = $RayCast2D3.global_transform.origin
			var collision_point = $RayCast2D3.get_collision_point()
			var distance = origin.distance_to(collision_point)
			var idk = round(distance / 8)
			for i in idk:
				self.global_position += Vector2(-8, 0)
			var glob = self.global_position
			self.global_position = $"..".global_position
			return glob
	if $RayCast2D4.is_colliding():
		if $RayCast2D4.get_collider().is_in_group("enemy") == false and $RayCast2D4.get_collider().is_in_group("body"):
			var origin = $RayCast2D4.global_transform.origin
			var collision_point = $RayCast2D4.get_collision_point()
			var distance = origin.distance_to(collision_point)
			var idk = round(distance / 8)
			for i in idk:
				self.global_position += Vector2(0, -8)
			var glob = self.global_position
			self.global_position = $"..".global_position
			return glob
	return Vector2.ZERO