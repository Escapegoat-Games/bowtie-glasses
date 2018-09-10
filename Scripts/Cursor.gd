"""
Cursor for examining npcs and objects
"""

extends Sprite

onready var ani = $AnimationPlayer

var is_examining = false

func _ready():
	reset()
	pass

func _process(delta):
	
	if not is_examining and GameManager.game_state == GameManager.GameState.PLAYING:
		position = get_global_mouse_position()
	
	var active_exists = false
	for obj in get_tree().get_nodes_in_group("Interactable"):
		if obj.is_selected:
			active_exists = true
			break
	
	# change color when on obj
	if active_exists:
		modulate = Color(1, 1, 0)
	else:
		modulate = Color(1, 1, 1)
	
	# click
	if Input.is_action_just_pressed("shoot") and not is_examining and active_exists:
		is_examining = true
		ani.play("Flash")

func reset():
	is_examining = false
	visible = true
	texture = load("res://Textures/UI/cursor.png")