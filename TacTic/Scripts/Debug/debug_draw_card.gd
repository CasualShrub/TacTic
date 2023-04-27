extends Button

func _on_pressed():
	EventManager.emit_card_draw(1)
