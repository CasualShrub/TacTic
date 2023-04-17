extends Node

var is_dragging: bool
var is_pressing: bool

var game_state

func _ready():
	is_dragging = false
	is_pressing = false

func _input(event):
	if event.is_action_pressed("menu"):
		show_settings()

func show_settings():
	print("menu showing")
