extends Area2D

var tile_scene = preload("res://Scenes/Tile.tscn")

var tile_count
var tile_array = []
var grid_size = 5

signal game_end_signal

func logs_enabled():
	return false

func _ready():
	setup_tiles()
	
func setup_tiles():
	instantiate_tiles()
	design_tiles()
	set_tile_vectors()
	
func instantiate_tiles():
	for i in range(grid_size * grid_size):
		var tile = tile_scene.instantiate()
		add_child(tile)
		tile_array.append(tile) 
	tile_count = tile_array.size()

func design_tiles():
	var tile_pos = Vector2(-32,-32)
	for i in tile_count:
		tile_array[i].set_variant(i%2)
		tile_array[i].position += tile_pos
		tile_pos.x += 16
		if ((i+1)%grid_size == 0):
			tile_pos.x = -32
			tile_pos.y += 16

func set_tile_vectors():
	for i in tile_count:
		var x = i % grid_size
		var y = i / grid_size
		tile_array[i].tile_id = Vector2(x, y)
		
		if logs_enabled():
			print("Tile %d has coordinates (%d, %d)" % [i,x,y])

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
#	var diagonal1 = []
#	diagonal1.append(tile_array[0])
#	diagonal1.append(tile_array[4])
#	diagonal1.append(tile_array[8])
#	var diagonal2 = []
#	diagonal2.append(tile_array[2])
#	diagonal2.append(tile_array[4])
#	diagonal2.append(tile_array[6])
#
#	evaluate_line(diagonal1)
#	evaluate_line(diagonal2)

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
