extends Node2D

var shape_type = "empty"
var is_hovered = false
var is_gone = false

var mpos = Vector2()

@onready var BackgroundSprite = $BackgroundSprite
@onready var ShapeSprite = $ShapeSprite

signal card_dragged

func _ready():
	randomize_shape()
	
func _input(event):
	if event.is_action_pressed("randomize"):
		randomize_shape()
		
func randomize_shape():
	var random_int = randi_range(0,2)
	match random_int:
		0:
			shape_type = "O"
		1:
			shape_type = "X"
		2:
			shape_type = "Triangle"
	
	ShapeSprite.play(shape_type)

func _on_mouse_entered():
	if !is_gone:
		is_hovered = true
		BackgroundSprite.play("%s_hovered" % "cardback")

func _on_mouse_exited():
	if !is_gone:
		is_hovered = false
		BackgroundSprite.play("%s_default" % "cardback")

func _on_input_event(_viewport, event, _shape_idx):
	if is_hovered:
		if (event.is_pressed()):
			is_gone = true
			BackgroundSprite.play("%s_dissapear" % "cardback")
			ShapeSprite.visible = false
			
			GameManager.is_dragging = true
			emit_signal("card_dragged", shape_type)
			
func reappear():
	BackgroundSprite.play_backwards("%s_dissapear" % "cardback")
	
