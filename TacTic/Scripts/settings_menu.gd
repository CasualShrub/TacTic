extends CanvasLayer

var is_showing = false;
var is_animating = false;

func _input(event):
	if event.is_action_pressed("menu"):
		if (is_animating == false):
			if (is_showing == false):
				$Menu/AnimationPlayer.play("Appear")
			else:
				$Menu/AnimationPlayer.play("Disappear")

func has_finished_appearing():
	is_showing = true
	is_animating = false
	
func has_finished_disappearing():
	is_showing = false
	is_animating = false

