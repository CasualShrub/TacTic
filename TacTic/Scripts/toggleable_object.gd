class_name ToggleableObject
extends Area2D

var BackgroundSprite: AnimatedSprite2D
var CollisionBox: CollisionShape2D
var is_toggled: bool

func _ready():
	self.input_event.connect(on_input_event)
	is_toggled = false
	for child in get_children():
		if child is AnimatedSprite2D:
			BackgroundSprite = child
			BackgroundSprite.play("idle")
			break

func on_input_event(_viewport, event, _shape_idx):
	if (event.is_pressed()):
		if is_toggled:
			BackgroundSprite.play("idle")
		else:
			BackgroundSprite.play("click")
		is_toggled = !is_toggled
