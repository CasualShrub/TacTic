class_name Tile
extends Area2D

var tile_type = 0
var tile_id = Vector2(0,0)
var shape_type = "empty"

var shape_being_dragged = "empty"

var has_object = false
var is_hovered = false

var adjacent_tiles: Array[Tile]

@onready var BackgroundSprite = $BackgroundSprite
@onready var ObjectSprite = $ObjectSprite

enum Direction {NW, N, NE, E, SE, S, SW, W}

signal shape_added(shape)

signal card_dropped(is_valid_drop)

func set_variant(value):
	tile_type = value
	BackgroundSprite.play("variant%d" % tile_type)

func modulate_color(shade):
	BackgroundSprite.modulate = shade

func set_shape(value):
	has_object = true;
	shape_type = value
	
	if (shape_being_dragged != "empty"):
		shape_being_dragged = "empty"
	
	ObjectSprite.play("%s" % shape_type)
	emit_signal("shape_added", shape_type)

func highlight_shape():
	if (shape_type != "empty"):
		ObjectSprite.play("%s_win" % shape_type)

func _on_Tile_input_event(_viewport, event, _shape_idx):
	if is_hovered:
		if (event.is_pressed()):
			BackgroundSprite.play("variant%d_clicked" % tile_type)
			show_adjacents()
		elif (event.is_action_released("click") && GameManager.is_dragging):
			if (!has_object):
				BackgroundSprite.play("variant%d" % tile_type)
				set_shape(GameManager.shape_being_dragged)
				GameManager.is_dragging = false
				EventManager.emit_card_drag_success(tile_id)
			else:
				EventManager.emit_card_drag_fail()

func show_adjacents():
	print("Tile (%d,%d) has adjacent tiles: " % [tile_id.x, tile_id.y])
	for tile in adjacent_tiles:
		print("Tile (%d,%d)" % [tile.tile_id.x, tile.tile_id.y])
		tile.modulate_color(Color("YELLOW"))

func get_matches_for_direction(direction: Direction, container: Array[Tile], shape: String):
	if (adjacent_tiles[direction] == null):
		return container
	
	if (adjacent_tiles[direction].shape_type != shape):
		return container

	container.append(adjacent_tiles[direction])
	return adjacent_tiles[direction].get_matches_for_direction(direction, container, shape)

func _on_Tile_mouse_entered():
	is_hovered = true
	if !has_object:
		BackgroundSprite.play("variant%d_hovered" % tile_type)

func _on_Tile_mouse_exited():
	is_hovered = false
	if !has_object:
		BackgroundSprite.play("variant%d" % tile_type)
