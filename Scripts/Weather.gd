"""
Weather that follows Player
"""

extends Node2D

onready var rain = $RainParticles
var player

func _ready():
	rain.emitting = true
	player = get_node("/root/Main/Player")

func _process(delta):
	position = Vector2(player.position.x, player.position.y)