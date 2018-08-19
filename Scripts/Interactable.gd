extends Sprite

export(Array, String) var dialogue
var is_selected = false

func _process(delta):
	if Input.is_action_just_pressed("shoot") and is_selected and GameManager.game_state == GameManager.GameState.PLAYING:
		UIManager.load_text(dialogue)

func _on_Area2D_area_entered(area):
	modulate = Color(1, 0, 0)
	is_selected = true

func _on_Area2D_area_exited(area):
	modulate = Color(1, 1, 1)
	is_selected = false
