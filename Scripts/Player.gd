"""
Player control and animation
"""

extends KinematicBody2D

onready var head_sprite = $Sprites/HeadSprite
onready var body_sprite = $Sprites/BodySprite
onready var hand_sprite = $Sprites/HandSprite
onready var ani = $AnimationPlayer

const WALK_SPEED = 300
const RUN_SPEED = 800
const GRAVITY = 10
const NORM = Vector2(0, -1)

var speed = WALK_SPEED
var velocity = Vector2(0, 0)
var is_flipped = false

enum State{
	IDLE,
	MOVING,
	JUMPING,
}
var state = State.IDLE

func _ready():
	pass
	
func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
		state = State.IDLE
	else:
		velocity.y += GRAVITY

func _process(delta):
	
	# movement
	if Input.is_action_pressed("dash"):
		speed = RUN_SPEED
	else:
		speed = WALK_SPEED
		
	if state != State.JUMPING:
		velocity.x = 0
		if Input.is_action_pressed("move_right"):
			velocity.x = speed
			is_flipped = false
			if state != State.JUMPING:
				state = State.MOVING
		elif Input.is_action_pressed("move_left"):
			velocity.x = -speed
			is_flipped = true
			if state != State.JUMPING:
				state = State.MOVING
		if Input.is_action_pressed("jump") and is_on_floor():
			state = State.JUMPING
			velocity += Vector2(0, -800)
			ani.play("JumpInit")
		
	move_and_slide(velocity, NORM)
	
	# hand follows mouse
	update_hand()

	# animation
	head_sprite.flip_h = is_flipped
	body_sprite.flip_h = is_flipped
	hand_sprite.flip_v = is_flipped
	
	if not ani.is_playing() and (state == State.IDLE or state == State.MOVING):
		ani.play("Walk")
	# play landing
	if is_on_floor() and state == State.JUMPING:
		ani.play("JumpEnd")

func update_hand():
	var loc_mouse_pos = get_global_mouse_position()
	loc_mouse_pos = Vector2(loc_mouse_pos.x - position.x, loc_mouse_pos.y - position.y)
	var rot = rad2deg(atan2(loc_mouse_pos.y, loc_mouse_pos.x))
	
	# transform
	hand_sprite.position = loc_mouse_pos.normalized() * 130 + Vector2(0, -50)
	hand_sprite.rotation_degrees = rot
				