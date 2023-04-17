extends Area2D

var BackgroundSprite: AnimatedSprite2D
var CollisionBox: CollisionShape2D

func _ready():
	self.input_event.connect(on_input_event)
	for child in get_children():
		if child is AnimatedSprite2D:
			BackgroundSprite = child
			BackgroundSprite.play("idle")
			break

func on_input_event(_viewport, event, _shape_idx):
	if (event.is_pressed()):
		BackgroundSprite.play("click")
		GameManager.is_pressing = true
	elif (event.is_action_released("click") && GameManager.is_pressing):
		BackgroundSprite.play("idle")
		GameManager.is_pressing = false
