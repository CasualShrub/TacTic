extends Area2D

var tile_count
var tile_array = []
var grid_size

signal game_end_signal

func logs_enabled():
	return false

func _ready():
	for child in get_children():
		if child is Area2D:
			tile_array.append(child)
	
	tile_count = tile_array.size()
	grid_size = sqrt(tile_count)
	design_tiles()
	setup_tile_vectors()

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
	#build arrays for horizontal and vertical
	for row in grid_size:
		var horizontal = []
		var vertical = []
		for column in grid_size:
			horizontal.append(get_tile_by_vector(Vector2(column, row)))
			vertical.append(get_tile_by_vector(Vector2(row, column)))
		evaluate_line(horizontal)
		evaluate_line(vertical)
		
	#build arrays for both diagonals
	var diagonal1 = []
	diagonal1.append(tile_array[0])
	diagonal1.append(tile_array[4])
	diagonal1.append(tile_array[8])
	var diagonal2 = []
	diagonal2.append(tile_array[2])
	diagonal2.append(tile_array[4])
	diagonal2.append(tile_array[6])
	
	evaluate_line(diagonal1)
	evaluate_line(diagonal2)

func evaluate_line(tiles):
	var is_complete = true
	var type = tiles[0].shape_type
	for tile in tiles:
		if tile.shape_type != type:
			is_complete = false
			break
	if is_complete:
		game_end()
		highlight_tiles_win(tiles)

func highlight_tiles_win(tiles):
	for tile in tiles:
		tile.highlight_shape()

func game_end():
	emit_signal("game_end_signal");

func get_tile_by_vector(value):
	for tile in tile_array:
		if tile.tile_id == value:
			return tile

func setup_tile_vectors():
	for i in tile_count:
		var x = i % 3
		var y = i / 3
		tile_array[i].tile_id = Vector2(x, y)
		
		if logs_enabled():
			print("Tile %d has coordinates (%d, %d)" % [i,x,y])
