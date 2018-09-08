"""
NPC
"""

extends Node2D

export(Texture) var head_texture
export(Texture) var body_texture
export(Array, String) var dialogue
export(Array, String) var serial_thoughts
export(String) var npc_name

onready var ani = $BodyAnimation
onready var effect_ani = $EffectAnimation
onready var head_sprite = $Sprites/HeadSprite
onready var body_sprite = $Sprites/BodySprite
onready var serial_disp_sprite = $Sprites/SerialDisp
onready var serial_disp_label = $Sprites/SerialDisp/Label
onready var timer = $Timer

var is_selected = false
var serial_index = 0

func _ready():
	ani.play("Walk")
	head_sprite.texture = head_texture
	body_sprite.texture = body_texture
	serial_disp_label.text = ""

func _process(delta):
	
	if Input.is_action_just_pressed("shoot") and is_selected and GameManager.game_state == GameManager.GameState.PLAYING:
		
		UIManager.load_text(dialogue)
		
		# disable serial thoughts
		toggle_serial_disp(false)
		
		# face player
		var player = get_node("/root/Main/Player")
		if position.x > player.position.x:
			head_sprite.flip_h = true
			body_sprite.flip_h = true
		else:
			head_sprite.flip_h = false
			body_sprite.flip_h = false

func toggle_serial_disp(b):
	if b:
		effect_ani.play("ShowSerialDisp")
	else:
		if serial_disp_sprite.scale.x > 0.1:
			effect_ani.play_backwards("ShowSerialDisp")
		serial_disp_label.text = ""
		serial_index = 0

func update_serial_text():
	if serial_index < len(serial_thoughts):
		serial_disp_label.text += serial_thoughts[serial_index] + "\n"
		serial_index += 1

func _on_Area2D_area_entered(area):
	is_selected = true
	toggle_serial_disp(is_selected)

func _on_Area2D_area_exited(area):
	is_selected = false
	toggle_serial_disp(is_selected)

func _on_Timer_timeout():
	# display serial text
	if is_selected and not effect_ani.is_playing():
		update_serial_text()
