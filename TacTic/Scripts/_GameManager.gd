extends Node

var is_dragging: bool
var is_pressing: bool

var game_state

func _ready():
	is_dragging = false
	is_pressing = false

func show_settings():
	simulate_action("menu")

func simulate_action(action_name: String):
	var event:InputEventAction = InputEventAction.new()
	event.action = action_name
	event.pressed = true
	Input.parse_input_event(event)

