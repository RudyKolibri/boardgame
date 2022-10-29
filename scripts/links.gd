extends RayCast2D

var origin = global_position
var collision_point = get_collision_point()
var distance = origin.distance_to(collision_point)
