extends Node2D

@onready var TileGrid = $TileGrid


func _ready():
	TileGrid.design_game_start()
	
	TileGrid.connect("game_end_signal", Callable(self, 	"on_game_end"))
	
	for i in TileGrid.tile_count:
		var tile = get_node("TileGrid/Tile%d" % (i+1) )
		tile.connect("shape_added",Callable(self,"on_shape_added"))

func on_shape_added(shape):
	TileGrid.evaluate_grid()
	
func on_game_end():
	print("bruh")
