extends Node2D

@onready var TileGrid = $TileGrid
@onready var CardPanel = $CardPanel

func _ready():
	#TileGrid.design_game_start()
	TileGrid.connect("game_end_signal", Callable(self, 	"on_game_end"))
	
	for tile in TileGrid.tile_array:
		tile.connect("shape_added",Callable(self,"on_shape_added"))
		tile.connect("card_dropped",Callable(self,"on"))
	
	EventManager.card_picked_up.connect(on_card_picked_up)

func on_card_picked_up(shape_type):
	var dragPreview = load("res://Scenes/Ephemeral/CardDragSprite.tscn").instantiate()
	dragPreview.shape_type = shape_type
	add_child(dragPreview)
	
	GameManager.shape_being_dragged = shape_type

#TODO: instead of evaluating when card is dropped, evaluate when a card is added to grid
#Case in point: environemnt effect adds a shape?? Enemy adds a shape??
func on_shape_added(_shape):
	#TileGrid.evaluate_grid()
	pass

func on_game_end():
	print("game is over bruh")
