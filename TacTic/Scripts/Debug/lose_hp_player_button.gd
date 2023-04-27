extends Button

func _on_pressed():
	PlayerManager.lose_hp(1)
	EventManager.emit_player_damaged()
