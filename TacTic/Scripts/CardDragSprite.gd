extends AnimatedSprite2D

var shape_type = "empty"

func _ready():
	self.play("%s" % shape_type)
	pass 

func _process(_delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_released("click"):
		queue_free()
