extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogue = []
var current_dialogue_id = 0
var d_active = false
func _ready():
	$NinePatchRect.visible = false
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = - 1
	next_script()

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())
func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		return
	$NinePatchRect/text.text = dialogue[current_dialogue_id]['text']
