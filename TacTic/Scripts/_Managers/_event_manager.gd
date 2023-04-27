extends Node

#emitted when a player drags and releases a card to an invalid screen space
signal card_drag_fail
#emitted when a player drags and releases a card to a valid tile
signal card_drag_success(position: Vector2)
#emitted when a card is removed from hand
signal card_removed_from_hand(position: int)
#emitted when a card is drawn
signal card_draw(count: int)

#emitted when the player gets damaged
signal player_damaged

func is_logging_enabled():
	return false

func emit_card_drag_fail():
	emit_signal("card_drag_fail")
	if is_logging_enabled():
		print("Card drag failed!")

func emit_card_drag_success(position: Vector2):
	emit_signal("card_drag_success", position)
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

func emit_player_damaged():
	emit_signal("player_damaged")
	if is_logging_enabled():
		print("Player Damaged!")

func _input(event):
	if (event.is_action_pressed("draw")):
		emit_card_draw(1)
