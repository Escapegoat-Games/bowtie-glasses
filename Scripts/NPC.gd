extends Node2D

export(Texture) var head_texture
export(Texture) var body_texture

onready var ani = $AnimationPlayer
onready var head_sprite = $Sprites/HeadSprite
onready var body_sprite = $Sprites/BodySprite

func _ready():
	ani.play("Walk")
	head_sprite.texture = head_texture
	body_sprite.texture = body_texture