extends CanvasLayer

onready var dialogue_text = $UIBox/Dialogue
onready var dialogue_box = $UIBox

const NORM_COOLDOWN = 3
const PAUSE_COOLDOWN = 10
var cooldown = NORM_COOLDOWN
var curr_cooldown = cooldown

var lines = []
var text_index = 0
var line_index = 0
var curr_char = ""
var curr_d = ""

func _process(delta):
	if not GameManager.game_state == GameManager.GameState.DIALOGUE or get_node("/root/Main/Cursor").ani.is_playing():
		return
		
	dialogue_box.visible = true
	curr_cooldown = clamp(curr_cooldown - 1, 0, 100)
	if curr_cooldown > 0:
		return
	
	# Handle text movement
	if line_index >= len(lines):
		turn_off()
		return
	if text_index >= len(lines[line_index]):
		if Input.is_action_just_pressed("shoot"):
			text_index = 0
			line_index += 1
			curr_d = ""
			curr_char = ""
			cooldown = NORM_COOLDOWN
		return
	
	curr_cooldown = cooldown
	curr_char = lines[line_index][text_index]
	text_index += 1
	
	# detect special chars
	match curr_char:
		"@":
			cooldown = NORM_COOLDOWN
			return
		"#":
			cooldown = PAUSE_COOLDOWN
			return
	
	# append for now
	curr_d += curr_char
	dialogue_text.text = curr_d
	

func load_text(s):
	lines = s
	text_index = 0
	line_index = 0

func turn_off():
	dialogue_box.visible = false
	UIManager.turn_off()