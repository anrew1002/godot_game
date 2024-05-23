extends Button



func _on_pressed():
	GlobalInfo.player_state = GlobalInfo.PLAYER_STUFF.NONE
	print(GlobalInfo.player_state)