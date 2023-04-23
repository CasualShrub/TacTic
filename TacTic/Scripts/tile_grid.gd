extends Area2D

var tile_scene = preload("res://Scenes/Tile.tscn")

var tile_count: int
var tile_array: Array[Tile] = []
var grid_size: int = 5

signal game_end_signal

func logs_enabled():
	return false

func _ready():
	setup_tiles()
	
func setup_tiles():
	instantiate_tiles()
	design_tiles()
	setup_tile_vectors()
	setup_adjacent_tiles()
	
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
		tile_array[i].modulate_color(Color(1,1,1))
		tile_pos.x += 16
		if ((i+1)%grid_size == 0):
			tile_pos.x = -32
			tile_pos.y += 16

func setup_tile_vectors():
	for i in tile_count:
		var x = i % grid_size
		var y = i / grid_size
		tile_array[i].tile_id = Vector2(x, y)
		
		if logs_enabled():
			print("Tile %d has coordinates (%d, %d)" % [i,x,y])

func setup_adjacent_tiles():
	for tile in tile_array:
		var current_vector = tile.tile_id
		var target_vector: Vector2 = Vector2.ZERO
		var adjacent_tiles: Array[Tile] = []
		for i in 8:
			match i:
				0:
					#North-West
					target_vector.x = current_vector.x - 1
					target_vector.y = current_vector.y - 1
				1:
					#North
					target_vector.x = current_vector.x
					target_vector.y = current_vector.y - 1
				2:
					#North-East
					target_vector.x = current_vector.x + 1
					target_vector.y = current_vector.y - 1
				3:
					#East
					target_vector.x = current_vector.x + 1
					target_vector.y = current_vector.y
				4:
					#South-East
					target_vector.x = current_vector.x + 1
					target_vector.y = current_vector.y + 1
				5:
					#South
					target_vector.x = current_vector.x
					target_vector.y = current_vector.y + 1
				6:
					#South-West
					target_vector.x = current_vector.x - 1
					target_vector.y = current_vector.y + 1
				7:
					#West
					target_vector.x = current_vector.x - 1
					target_vector.y = current_vector.y
			if is_valid_tile(target_vector):
				var target_tile = get_tile_by_vector(target_vector)
				adjacent_tiles.append(target_tile)
		tile.adjacent_tiles = adjacent_tiles

func is_valid_tile(vector:Vector2):
	if vector.x < 0 || vector.x >= grid_size || vector.y < 0 || vector.y >= grid_size:
		return false
	return true

func design_game_start():
	tile_array[0].set_shape("X")
	tile_array[3].set_shape("X")
	tile_array[4].set_shape("O")
	tile_array[6].set_shape("O")
	tile_array[7].set_shape("X")
	tile_array[8].set_shape("O")

func evaluate_grid():
	#TODO: rework evaluation using linked nodes
	#build arrays for horizontal and vertical
	for row in grid_size:
		var horizontal = []
		var vertical = []
		for column in grid_size:
			horizontal.append(get_tile_by_vector(Vector2(column, row)))
			vertical.append(get_tile_by_vector(Vector2(row, column)))
		evaluate_line(horizontal)
		evaluate_line(vertical)

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
