extends AnimatedSprite2D

var shape_type: String = "empty"

signal card_released_signal

func _ready():
	self.play("%s" % shape_type)
	pass 

func _process(_delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_released("click"):
		emit_signal("card_released_signal")
		queue_free()
