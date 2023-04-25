class_name Card
extends Node2D

var shape_type: String = "empty"
var is_hovered: bool = false
var is_gone: bool = false

var mpos: Vector2 = Vector2()

@onready var BackgroundSprite = $BackgroundSprite
@onready var ShapeSprite = $ShapeSprite

signal card_dragged

func _ready():
	randomize_shape()
	EventManager.card_drag_fail.connect(Callable(self,"on_card_drag_fail"))
	EventManager.card_drag_success.connect(Callable(self,"on_card_drag_success"))
	
func _input(event):
	if event.is_action_pressed("randomize"):
		randomize_shape()
	elif event.is_action_pressed("draw"):
		draw()

func draw():
	pass

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

func on_card_drag_fail():
	if is_gone:
		reappear()

func on_card_drag_success():
	if is_gone:
		self.queue_free()

func _on_input_event(_viewport, event, _shape_idx):
	if is_hovered:
		if (event.is_pressed()):
			disappear()
			GameManager.is_dragging = true
			ShapeSprite.play("empty")
			ShapeSprite.visible = false
			emit_signal("card_dragged", shape_type)

func disappear():
	BackgroundSprite.play("%s_dissapear" % "cardback")
	is_gone = true

func reappear():
	BackgroundSprite.play_backwards("%s_dissapear" % "cardback")
	ShapeSprite.visible = true #TODO: call this at the end of the animation?
	is_gone = false
