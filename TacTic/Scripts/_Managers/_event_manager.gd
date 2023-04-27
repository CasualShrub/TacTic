extends Node

#emitted when a player drags and releases a card to an invalid screen space
signal card_drag_fail
#emitted when a player drags and releases a card to a valid tile
signal card_drag_success
#emitted when a card is removed from hand
signal card_removed_from_hand(position: int)
#emitted when a card is drawn
signal card_draw(count: int)

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

func emit_card_removed_from_hand(position: int):
	emit_signal("card_removed_from_hand", position)
	if is_logging_enabled():
		print("Card removed!")

func emit_card_draw(count: int):
	emit_signal("card_draw", count)
	if is_logging_enabled():
		print("Card/s drawn!: &d" % count)

func _input(event):
	if (event.is_action_pressed("draw")):
		emit_card_draw(1)
