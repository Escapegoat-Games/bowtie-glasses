extends Node

enum GameState {
	PLAYING,
	DIALOGUE,
}
var game_state

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	game_state = PLAYING