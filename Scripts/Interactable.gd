extends Sprite

func _process(delta):
	pass

func _on_Area2D_area_entered(area):
	modulate = Color(1, 0, 0)

func _on_Area2D_area_exited(area):
	modulate = Color(1, 1, 1)
