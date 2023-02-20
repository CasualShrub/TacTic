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
		
