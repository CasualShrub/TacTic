extends Node

#emitted when a player drags and releases a card to an invalid screen space
signal card_drag_fail
#emitted when a player drags and releases a card to a valid tile
signal card_drag_success

func is_logging_enabled():
	return false

func emit_card_drag_fail():
	emit_signal("card_drag_fail")
	if is_logging_enabled():
		print("Card drag failed!")

func emit_card_drag_success():
	emit_signal("card_drag_success")
	if is_logging_enabled():
		print("Card drag success!")
