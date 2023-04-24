extends Node2D

var tile_scene = preload("res://Scenes/Card.tscn")

var card_slot_count: int = 5
var card_array: Array[Card] = []

func _ready():
	instantiate_full_hand()
	design_cards()
	
func instantiate_full_hand():
	for i in range(card_slot_count):
		var card = tile_scene.instantiate()
		add_child(card)
		card_array.append(card)

#Cards are of size 18x18 with (-36,0) as starting position
func design_cards():
	var card_pos: Vector2 = Vector2(-36,0)
	for i in card_array.size():
		card_array[i].position += card_pos
		card_pos.x += 18
