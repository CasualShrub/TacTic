extends Node2D

var card_slot_count = 0
var card_array = []

func _ready():
	for child in get_children():
		if child is Area2D:
			card_array.append(child)
	card_slot_count = card_array.size()
