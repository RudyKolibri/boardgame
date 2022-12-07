extends Node2D
export var ray_cast_tiles = 4
func _ready():
	$RayCast2D.cast_to.x = ray_cast_tiles * 16
	$RayCast2D2.cast_to.y = ray_cast_tiles * 16
	$RayCast2D3.cast_to.x = - ray_cast_tiles * 16
	$RayCast2D4.cast_to.y = - ray_cast_tiles * 16
	$RayCast2D.add_exception($"..")
	$RayCast2D2.add_exception($"..")
	$RayCast2D3.add_exception($"..")
	$RayCast2D4.add_exception($"..")
	if not $"..".is_in_group("archer"):
		$RayCast2D.collision_mask = 1
		$RayCast2D3.collision_mask = 1
		$RayCast2D2.collision_mask = 1
		$RayCast2D4.collision_mask = 1
func getcol():
	print("check")
	self.global_position = $"..".global_position
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("body"):
			if $RayCast2D.get_collider().is_in_group("enemy") == false and $RayCast2D.get_collider().is_in_group("body"):
				var origin = $RayCast2D.global_transform.origin
				var collision_point = $RayCast2D.get_collision_point()
				var distance = origin.distance_to(collision_point)
				var idk = round(distance / 16)
				for i in idk:
					self.global_position += Vector2(16, 0)
				var glob = self.global_position
				self.global_position = $"..".global_position
				return glob
	if $RayCast2D2.is_colliding():
		if $RayCast2D2.get_collider().is_in_group("body"):
			if $RayCast2D2.get_collider().is_in_group("enemy") == false and $RayCast2D2.get_collider().is_in_group("body"):
				var origin = $RayCast2D2.global_transform.origin
				var collision_point = $RayCast2D2.get_collision_point()
				var distance = origin.distance_to(collision_point)
				var idk = round(distance / 16)
				for i in idk:
					self.global_position += Vector2(0, 16)
				var glob = self.global_position
				self.global_position = $"..".global_position
				return glob
	if $RayCast2D3.is_colliding():
		print("colliding")
		print($RayCast2D3.get_collider())
		if $RayCast2D3.get_collider().is_in_group("body"):
			if $RayCast2D3.get_collider().is_in_group("enemy") == false:
				var origin = $RayCast2D3.global_transform.origin
				var collision_point = $RayCast2D3.get_collision_point()
				var distance = origin.distance_to(collision_point)
				var idk = round(distance / 16)
				for i in idk:
					self.global_position += Vector2(-16, 0)
				var glob = self.global_position
				self.global_position = $"..".global_position
				return glob
	if $RayCast2D4.is_colliding():
		if $RayCast2D4.get_collider().is_in_group("body"):
			if $RayCast2D4.get_collider().is_in_group("enemy") == false and $RayCast2D4.get_collider().is_in_group("body"):
				var origin = $RayCast2D4.global_transform.origin
				var collision_point = $RayCast2D4.get_collision_point()
				var distance = origin.distance_to(collision_point)
				var idk = round(distance / 16)
				for i in idk:
					self.global_position += Vector2(0, -16)
				var glob = self.global_position
				self.global_position = $"..".global_position
				return glob
	return Vector2.ZERO
