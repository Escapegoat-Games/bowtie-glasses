"""
Follows Player
"""

extends Node2D

var player

func _ready():
	player = get_node("/root/Main/Player")

func _process(delta):
	position = Vector2(player.position.x, player.position.y)