extends Node2D

var card_object = preload("res://Scenes/Card.tscn")

var card_slot_count: int = 5
var card_array: Array[Card] = []
var card_size: int = 18

func _ready():
	instantiate_full_hand()
	design_cards()
	EventManager.card_removed_from_hand.connect(on_card_removed)
	EventManager.card_draw.connect(on_card_draw)

func instantiate_full_hand():
	instantiate_cards(card_slot_count)
	update_card_info()

func update_card_info():
	for i in range(card_array.size()):
		card_array[i].position_in_hand = i

func reset_card_positions():
	for card in card_array:
		card.position = Vector2(0,0)

#Cards are of size 18x18 with (-36,0) as starting position
func design_cards():
	reset_card_positions()
	var card_pos: Vector2 = Vector2(-36,0)
	for i in card_array.size():
		card_array[i].position += card_pos
		card_pos.x += card_size

func on_card_draw(count: int):
	draw_card(count)

func instantiate_cards(count: int = 1):
	var position_to_drop: int = card_array.size()
	
	var spawn_position: Vector2 = Vector2(56,0)
	for i in count:
		var card = card_object.instantiate()
		add_child(card)
		card.position += spawn_position
		spawn_position.x += card_size
		card_array.append(card)
	
	var empty_vector: Vector2 = get_card_vector_for_position(position_to_drop)
	var distance_from_empty: Vector2 = Vector2.ZERO
	var tween: Tween = create_tween()
	tween.set_parallel()
	for i in range(position_to_drop, card_array.size()):
		if (card_array[i] != null):
			distance_from_empty = Vector2((card_size * (i - position_to_drop)),0)
			var final_position = empty_vector + distance_from_empty
			tween.tween_property(card_array[i], "position", final_position, 0.4).set_trans(Tween.TRANS_EXPO)

	
	update_card_info()

func draw_card(count: int = 1):
	instantiate_cards(count)

func on_card_removed(position_to_drop: int):
	#remove empty object at array
	card_array.remove_at(position_to_drop)
	update_card_info()
	
	var empty_vector: Vector2 = get_card_vector_for_position(position_to_drop)
	var distance_from_empty: Vector2 = Vector2.ZERO

	var tween: Tween = create_tween()
	tween.set_parallel()
	for i in range(position_to_drop, card_array.size()):
		if (card_array[i] != null):
			distance_from_empty = Vector2((card_size * (i - position_to_drop)),0)
			var final_position = empty_vector + distance_from_empty
			tween.tween_property(card_array[i], "position", final_position, 0.4).set_trans(Tween.TRANS_EXPO)

func get_card_vector_for_position(empty_position: int):
	var card_vector: Vector2 = Vector2(-36,0)
	card_vector.x += (card_size * empty_position)
	return card_vector

func animate_card_drop():
	pass
