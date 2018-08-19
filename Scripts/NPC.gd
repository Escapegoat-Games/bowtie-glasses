extends Node2D

export(Texture) var head_texture
export(Texture) var body_texture
export(Array, String) var dialogue

onready var ani = $AnimationPlayer
onready var head_sprite = $Sprites/HeadSprite
onready var body_sprite = $Sprites/BodySprite

var is_selected

func _ready():
	ani.play("Walk")
	head_sprite.texture = head_texture
	body_sprite.texture = body_texture

func _process(delta):
	if Input.is_action_just_pressed("shoot") and is_selected and GameManager.game_state == GameManager.GameState.PLAYING:
		UIManager.load_text(dialogue)
		
		# face player
		var player = get_node("/root/Main/Player")
		if position.x > player.position.x:
			head_sprite.flip_h = true
			body_sprite.flip_h = true
		else:
			head_sprite.flip_h = false
			body_sprite.flip_h = false

func _on_Area2D_area_entered(area):
	is_selected = true


func _on_Area2D_area_exited(area):
	is_selected = false
