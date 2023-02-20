extends Area2D


func set_variant(value):
	$BackgroundSprite.play("variant%d" % value)


func _on_Tile_input_event(viewport, event, shape_idx):
	
	if event.is_pressed():
		print("clicked %s" % self.name)
	#Handle clicking the tile
	pass
