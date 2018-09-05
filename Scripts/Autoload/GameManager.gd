extends Node

enum GameState {
	PLAYING,
	DIALOGUE,
}
var game_state

func _ready():
	
	# set bg
	ProjectSettings.set_setting("rendering/environment/default_clear_color", Color("#2a2c47"))
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	game_state = PLAYING