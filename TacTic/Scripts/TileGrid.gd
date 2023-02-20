extends Area2D

var tileArray = []


func _ready():
	for child in get_children():
		if child is Area2D:
			tileArray.append(child)
	
	design_tiles()
			
			
	pass # Replace with function body.

func design_tiles():
	for i in range(tileArray.size()):
		tileArray[i].set_variant(i%2)

func design_game_start():
	tileArray[0].set_shape("X")
	tileArray[3].set_shape("X")
	tileArray[4].set_shape("O")
	tileArray[6].set_shape("O")
	tileArray[7].set_shape("X")
	tileArray[8].set_shape("O")

