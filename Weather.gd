"""
Weather node
"""

extends "res://Scripts/PlayerFollower.gd"

onready var rain = $RainParticles

func _ready():
	rain.emitting = true