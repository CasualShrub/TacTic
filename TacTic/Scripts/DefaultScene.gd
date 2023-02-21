extends Node2D


func _ready():
	$TileGrid.design_game_start()
	
	for i in $TileGrid.tile_count :
		var tile = get_node("TileGrid/Tile%d" % (i+1) )
		tile.connect("shape_added", self, "on_shape_added")

func on_shape_added(shape):
	print("ADDED SHAPE " + shape)

func _input(event):
	if event.is_action_pressed("menu"):
		$Menu.visible = !$Menu.visible

