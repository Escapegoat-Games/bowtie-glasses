extends KinematicBody2D

onready var head_sprite = $Sprites/HeadSprite
onready var body_sprite = $Sprites/BodySprite
onready var hand_sprite = $Sprites/HandSprite
onready var ani = $AnimationPlayer

const MOVE_SPEED = 300
const GRAVITY = 10
const NORM = Vector2(0, -1)

var motion
var y_vel = 0
var is_jumping = false
var is_moving = false
var is_flipped = false

func _ready():
	pass
	
func _physics_process(delta):
	if is_on_floor():
		y_vel = 0
		is_jumping = false
	else:
		y_vel += GRAVITY

func _process(delta):
	motion = Vector2(0, 0)
	is_moving = false
	
	# movement
	if Input.is_action_pressed("move_right"):
		motion += Vector2(MOVE_SPEED, 0)
		is_flipped = false
		is_moving = true
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-MOVE_SPEED, 0)
		is_flipped = true
		is_moving = true
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_jumping = true
		y_vel = -500
	
	motion += Vector2(0, y_vel)
	move_and_slide(motion, NORM)

	update_hand()

	# animation
	head_sprite.flip_h = is_flipped
	body_sprite.flip_h = is_flipped
	hand_sprite.flip_v = is_flipped
	
	# temp bool crap
	if not ani.is_playing() and is_moving and not is_jumping:
		ani.play("Walk")
	elif ani.is_playing() and not is_moving or is_jumping:
		ani.stop()

func update_hand():
	var loc_mouse_pos = get_global_mouse_position()
	loc_mouse_pos = Vector2(loc_mouse_pos.x - position.x, loc_mouse_pos.y - position.y)
	var rot = rad2deg(atan2(loc_mouse_pos.y, loc_mouse_pos.x))
	
	# transform
	hand_sprite.position = loc_mouse_pos.normalized() * 130 + Vector2(0, -50)
	hand_sprite.rotation_degrees = rot