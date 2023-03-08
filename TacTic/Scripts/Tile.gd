extends Area2D

var tile_type = 0
var tile_id = Vector2(0,0)
var shape_type = "empty"

var shape_being_dragged = "empty"

var has_object = false
var is_hovered = false

@onready var BackgroundSprite = $BackgroundSprite
@onready var ObjectSprite = $ObjectSprite

signal shape_added(shape)

signal card_dropped(is_valid_drop)

func set_variant(value):
	tile_type = value
	BackgroundSprite.play("variant%d" % tile_type)

func set_shape(value):
	has_object = true;
	shape_type = value
	
	if (shape_being_dragged != "empty"):
		shape_being_dragged = "empty"
	
	ObjectSprite.play("%s" % shape_type)
	emit_signal("shape_added", shape_type)
	
func highlight_shape():
	ObjectSprite.play("%s_win" % shape_type)

func _on_Tile_input_event(_viewport, event, _shape_idx):
	if is_hovered:
		if (event.is_pressed()):
			BackgroundSprite.play("variant%d_clicked" % tile_type)
		elif (event is InputEventMouseButton && event.is_action_released("click")):
			if (!has_object):
				BackgroundSprite.play("variant%d" % tile_type)
				set_shape(shape_being_dragged)
			else:
				#emit signal to return shape to original container
				pass

func _on_Tile_mouse_entered():
	is_hovered = true
	if !has_object:
		BackgroundSprite.play("variant%d_hovered" % tile_type)

func _on_Tile_mouse_exited():
	is_hovered = false
	if !has_object:
		BackgroundSprite.play("variant%d" % tile_type)
