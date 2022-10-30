extends Node2D

func _ready():
	$AnimationPlayer.play("attack")
func _on_attack_body_entered(body):
	print("hit " , str(body))
func kill():
	queue_free()
