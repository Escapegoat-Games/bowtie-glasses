extends KinematicBody2D

const MOVE_SPEED = 300
const GRAVITY = 10
const NORM = Vector2(0, -1)

var motion
var y_vel = 0
var is_jumping = false

func _ready():
	pass
	
func _physics_process(delta):
	if is_on_floor():
		y_vel = 0
	else:
		y_vel += GRAVITY

func _process(delta):
	
	print(is_on_floor())
	
	motion = Vector2(0, 0)
	
	# movement
	if Input.is_action_pressed("move_right"):
		motion += Vector2(MOVE_SPEED, 0)
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-MOVE_SPEED, 0)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
		y_vel = -500
	
	motion += Vector2(0, y_vel)
	
	move_and_slide(motion, NORM)