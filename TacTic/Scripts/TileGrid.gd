extends Area2D

var tile_count
var tile_array = []

func logs_enabled():
	return false

func _ready():
	for child in get_children():
		if child is Area2D:
			tile_array.append(child)
	
	tile_count = tile_array.size()
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
	#evaluate rows
	var is_complete 
		
	for row in 3:
		var horizontal = []
		var vertical = []
		for column in 3:
			horizontal.append(get_tile_by_vector(Vector2(column, row)))
			vertical.append(get_tile_by_vector(Vector2(row, column)))

		var type = horizontal[0].shape_type
		is_complete = true
		
		for tile in horizontal:
			if tile.shape_type != type:
				is_complete = false
				break
				
		if is_complete:
			game_end()
			return
			
		is_complete = true
		type = vertical[0].shape_type
		for tile in vertical:
			if tile.shape_type != type:
				is_complete = false
				break

		if is_complete:
			game_end()
			return

func game_end():
	print("GAME END!")

func get_tile_by_vector(value):
	for tile in tile_array:
		if tile.tile_id == value:
			return tile

func setup_tile_vectors():
	for i in tile_count:
		var x = i % 3
		var y = i / 3
		tile_array[i].tile_id = Vector2(x, y)
		if logs_enabled:
			print("Tile %d has coordinates (%d, %d)" % [i,x,y])
