extends ClickableObject


func on_input_event(_viewport, event, _shape_idx):
	super(_viewport, event, _shape_idx)
	if (event.is_pressed()):
		GameManager.show_settings()
