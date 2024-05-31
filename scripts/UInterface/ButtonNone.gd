extends TextureButton

var handTexture = preload("res://assets/textures/cursor.svg")

func _on_pressed():
	GlobalInfo.player_state = GlobalInfo.PLAYER_STUFF.NONE
	print(GlobalInfo.player_state)
	GlobalInfo.firstCupOfBeads = true
	Input.set_custom_mouse_cursor(handTexture, 0, Vector2(20,0))