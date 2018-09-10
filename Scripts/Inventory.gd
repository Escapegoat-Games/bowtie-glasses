extends Control

onready var ani = $AnimationPlayer

var items = []
var profiles = []

func _process(delta):
	
	# Toggle inventory on command
	if Input.is_action_just_pressed("check_invent"):
		if GameManager.game_state == GameManager.GameState.PLAYING:
			GameManager.game_state = GameManager.GameState.INVENTORY
			ani.play("ShowInvent")
		elif GameManager.game_state == GameManager.GameState.INVENTORY:
			GameManager.game_state = GameManager.GameState.PLAYING
			ani.play_backwards("ShowInvent")
			get_node("/root/Main/Cursor").reset()