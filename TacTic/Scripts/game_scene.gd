extends Node2D

@onready var TileGrid = $TileGrid
@onready var CardPanel = $CardPanel

func _ready():
	#TileGrid.design_game_start()
	TileGrid.connect("game_end_signal", Callable(self, 	"on_game_end"))
	
	for tile in TileGrid.tile_array:
		tile.connect("shape_added",Callable(self,"on_shape_added"))
		tile.connect("card_dropped",Callable(self,"on"))
	
	for card_slot in CardPanel.card_array:
		card_slot.connect("card_dragged",Callable(self, "on_card_dragged"))

func on_card_dragged(shape_type):
	var dragPreview = load("res://Scenes/CardDragSprite.tscn").instantiate()
	dragPreview.shape_type = shape_type
	add_child(dragPreview)
	
	GameManager.shape_being_dragged = shape_type

func on_shape_added(_shape):
	TileGrid.evaluate_grid()

func on_game_end():
	print("game is over bruh")
