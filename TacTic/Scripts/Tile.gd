extends Area2D

var tile_type = 0
var tile_id = Vector2(0,0)
var shape_type = "empty"

var has_object = false
var is_hovered = false

signal shape_added(shape)

func set_variant(value):
	tile_type = value
	$BackgroundSprite.play("variant%d" % tile_type)

func set_shape(value):
	has_object = true;
	shape_type = value
	$ObjectSprite.play("%s" % shape_type)
	emit_signal("shape_added", shape_type)

func _on_Tile_input_event(_viewport, event, _shape_idx):
	if is_hovered:
		if (event.is_pressed()):
			$BackgroundSprite.play("variant%d_clicked" % tile_type)
		elif (event is InputEventMouseButton && event.is_action_released("click")):
			$BackgroundSprite.play("variant%d" % tile_type)
			set_shape("O")

func _on_Tile_mouse_entered():
	is_hovered = true
	if !has_object:
		$BackgroundSprite.play("variant%d_hovered" % tile_type)

func _on_Tile_mouse_exited():
	is_hovered = false
	if !has_object:
		$BackgroundSprite.play("variant%d" % tile_type)
