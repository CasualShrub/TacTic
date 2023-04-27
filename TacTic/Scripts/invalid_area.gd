extends Area2D

signal drag_failed #TODO: Edit tiles so that they also emit drag_failed OR dispatch

func _on_input_event(_viewport, event, _shape_idx):
	if (event.is_action_released("click") && GameManager.is_dragging):
		EventManager.emit_card_drag_fail()
