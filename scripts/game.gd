extends Node2D
signal start
export(String, FILE) var next_level : String = ""
func _ready():
	$AudioStreamPlayer2D.play()
	$turnbased.play_turn()	
	emit_signal("start")
func game_over():
	var _reload =  get_tree().reload_current_scene()
func game_won():
	var _scene = Loader.change_scene(next_level, $Camera2D.zoom)
func change_camera(_camera):
	pass
	#$Camera2D.zooms(-(camera.x - 1))
