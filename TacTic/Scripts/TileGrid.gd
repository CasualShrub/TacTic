extends Area2D

var tile_count
var tile_array = []

func _ready():
	for child in get_children():
		if child is Area2D:
			tile_array.append(child)
	
	tile_count = tile_array.size()
	design_tiles()
	setup_tile_vectors()
			
			
	pass # Replace with function body.

func design_tiles():
	for i in range(tile_count):
		tile_array[i].set_variant(i%2)

func design_game_start():
	tile_array[0].set_shape("X")
	tile_array[3].set_shape("X")
	tile_array[4].set_shape("O")
	tile_array[6].set_shape("O")
	tile_array[7].set_shape("X")
	tile_array[8].set_shape("O")

func evaluate_grid():
	pass
		
func setup_tile_vectors():
	for i in tile_array.size():
		var x = i % 3
		var y = i / 3
		tile_array[i].tile_id = Vector2(x, y)
		print("Tile %d has coordinates (%d, %d)" % [i,x,y])
