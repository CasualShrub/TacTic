extends ToggleableObject

var DebugLayer: CanvasLayer

func _ready():
	super()
	DebugLayer = get_node("DebugLayer")
	DebugLayer.visible = false

func on_input_event(_viewport, event, _shape_idx):
	super(_viewport, event, _shape_idx)
	DebugLayer.visible = is_toggled;
