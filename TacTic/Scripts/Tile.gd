extends Area2D

var variant = 0
var has_object = false
var is_hovered = false

func set_variant(value):
	variant = value
	$BackgroundSprite.play("variant%d" % variant)

func set_shape(value):
	has_object = true;
	$ObjectSprite.play("%s" % value)

func _on_Tile_input_event(_viewport, event, _shape_idx):
	if is_hovered:
		if event.is_pressed():
			$BackgroundSprite.play("variant%d_clicked" % variant)
		elif (event is InputEventMouseButton && event.is_action_released("click")):
			$BackgroundSprite.play("variant%d" % variant)
			set_shape("O")
		
	print("clicked %s" % self.name)

func _on_Tile_mouse_entered():
	is_hovered = true
	if !has_object:
		$BackgroundSprite.play("variant%d_hovered" % variant)

func _on_Tile_mouse_exited():
	is_hovered = false
	if !has_object:
		$BackgroundSprite.play("variant%d" % variant)
