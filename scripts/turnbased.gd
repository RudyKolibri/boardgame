extends Sprite
class_name turnbased
var active_character
var normalofset = Vector2(4, 4)
export var left_turns : int
var old_index
var player = []
var enemy = []
func _ready():
	active_character = get_child(0)
	$"../Camera2D".update_turns(left_turns)
func play_turn():
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	player.clear()
	enemy.clear()
	for child in get_child_count():
		var childrn = get_child(child)
		if childrn.is_in_group("enemy"):
			enemy.append(childrn)
		elif childrn.is_in_group("player"):
			player.append(childrn)
	if player.size() <= 0:
		$"..".game_over()
	if enemy.size() <= 0:
		$"..".game_won()
	if is_instance_valid(active_character):
		self.offset = active_character.position + normalofset
		active_character.turn()
		yield(active_character, "done")
		var new_index: int = (active_character.get_index() + 1) % get_child_count()
		if new_index % get_child_count() == 0:
			left_turns -= 1
			$"../Camera2D".update_turns(left_turns)
		active_character = get_child(new_index)
		old_index = new_index
		t = Timer.new()
		t.set_wait_time(0.7)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		play_turn()
	else:
		var new_index: int = (old_index + 1) % get_child_count()
		active_character = get_child(new_index)
		self.offset = active_character.position + normalofset
		active_character.turn()
		yield(active_character, "done")
		new_index = (active_character.get_index() + 1) % get_child_count()
		if new_index % get_child_count() == 0:
			left_turns -= 1
			$"../Camera2D".update_turns(left_turns)
		active_character = get_child(new_index)
		old_index = new_index
		t = Timer.new()
		t.set_wait_time(0.7)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		play_turn()
	if left_turns <= 0:
		$"..".game_over()
