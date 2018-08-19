extends Sprite

onready var ani = $AnimationPlayer

var is_examining = false

func _ready():
	reset()
	pass

func _process(delta):
	if not is_examining:
		position = get_global_mouse_position()
	
	# click
	if Input.is_action_just_pressed("shoot"):
		is_examining = true
		ani.play("Flash")

func reset():
	is_examining = false
	visible = true
	texture = load("res://Textures/UI/cursor.png")