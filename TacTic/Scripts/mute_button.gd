extends ClickableObject

var is_muted: bool

func _ready():
	super()
	is_muted = false
	
#TODO: change to resource/nodetype
func on_input_event(_viewport, event, _shape_idx):
	if (event.is_pressed()):
		on_pressed()
	elif (event.is_action_released("click") && GameManager.is_pressing):
		on_released();
		
func on_pressed():
	BackgroundSprite.play("click")
	GameManager.is_pressing = true
func on_released():
	BackgroundSprite.play("idle")
	GameManager.is_pressing = false
