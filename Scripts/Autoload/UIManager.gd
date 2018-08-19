extends Node

func load_text(s):
	get_node("/root/Main/HUD").load_text(s)
	GameManager.game_state = GameManager.GameState.DIALOGUE
	
func turn_off():
	GameManager.game_state = GameManager.PLAYING
	get_node("/root/Main/Cursor").reset()