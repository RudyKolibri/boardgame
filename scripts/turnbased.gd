extends Sprite
class_name turnbased
var active_character
var normalofset = Vector2(4, 4)
func _ready():
	active_character = get_child(0)
func play_turn():
	self.offset = active_character.position + normalofset
	active_character.turn()
	yield(active_character, "done")
	var new_index: int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	play_turn()
