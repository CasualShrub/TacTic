extends Node2D

var tile_scene = preload("res://Scenes/Card.tscn")

var card_slot_count: int = 5
var card_array: Array[Card] = []
var card_size: int = 18

func _ready():
	instantiate_full_hand()
	design_cards()
	EventManager.card_removed_from_hand.connect(on_card_removed)

func instantiate_full_hand():
	for i in range(card_slot_count):
		var card = tile_scene.instantiate()
		add_child(card)
		card_array.append(card)
	update_card_info()

func update_card_info():
	for i in range(card_array.size()):
		card_array[i].position_in_hand = i

#Cards are of size 18x18 with (-36,0) as starting position
func design_cards():
	var card_pos: Vector2 = Vector2(-36,0)
	for i in card_array.size():
		card_array[i].position += card_pos
		card_pos.x += card_size

func on_card_removed(position_in_hand: int):
	
	#remove empty object at array
	card_array.remove_at(position_in_hand)
	update_card_info()
	
	var empty_vector: Vector2 = get_card_vector_for_position(position_in_hand)
	var distance_from_empty: Vector2 = Vector2.ZERO
	
	print("Empty position:")
	print(empty_vector)
	print()

	var tween: Tween = create_tween()
	tween.set_parallel()
	for i in range(position_in_hand, card_array.size()):
		if (card_array[i] != null):
			distance_from_empty = Vector2((card_size * (i - position_in_hand)),0)
			var final_position = empty_vector + distance_from_empty
			tween.tween_property(card_array[i], "position", final_position, 0.4).set_trans(Tween.TRANS_EXPO)

func get_card_vector_for_position(empty_position: int):
	var card_vector: Vector2 = Vector2(-36,0)
	card_vector.x += (card_size * empty_position)
	return card_vector
