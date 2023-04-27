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
	EventManager.card_drag_success.connect(evaluate_grid)
	
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
			else:
				adjacent_tiles.append(null)
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

func evaluate_grid(start_position: Vector2):
	var new_tile: Tile = get_tile_by_vector(start_position)
	var matched_tiles: Array[Tile] = [new_tile]
	
	#0 = NW, 4 = SE --> Rotate through each direction by incrementing
	#For example next direction would be: 1 = N, 5 = S
	var direction1: int = 0
	var direction2: int = 4
	
	#evaluate for each direction (\, |, /, —)
	for i in 3:
		direction1 += i
		direction2 += i
		var matches: Array[Tile] = evaluate_line(new_tile, direction1, direction2)
		matched_tiles.append_array(matches) 
	
	if (matched_tiles.size() >= 3):
		for tile in matched_tiles:
			print(tile.tile_id)
			tile.modulate_color(Color.LIGHT_PINK)
			tile.animate_on_match()

func evaluate_line(center_tile: Tile, direction1: int, direction2: int):
	var eval_array: Array[Tile] = []
	eval_array = center_tile.get_matches_for_direction(direction1, eval_array, center_tile.shape_type)
	eval_array = center_tile.get_matches_for_direction(direction2, eval_array, center_tile.shape_type)
	return eval_array

func highlight_tiles_win(tiles):
	for tile in tiles:
		tile.highlight_shape()

func game_end():
	emit_signal("game_end_signal");

func get_tile_by_vector(value):
	for tile in tile_array:
		if tile.tile_id == value:
			return tile
