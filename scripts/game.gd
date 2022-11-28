extends Node2D
signal start
func _ready():
	$AudioStreamPlayer2D.play()
	$turnbased.play_turn()
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	emit_signal("start")
func game_over():
	var _reload =  get_tree().reload_current_scene()
