extends Node

var is_dragging: bool
var is_pressing: bool = false
var shape_being_dragged: String = "empty"

enum GameState {RESTORE, MAIN_MENU, SETTINGS_MENU, PLAYER_TURN, ENEMY_TURN}
var game_state: GameState

var player_position: Vector2 = Vector2.ZERO
var enemy_position: Vector2 = Vector2.ZERO


func _ready():
	is_dragging = false
	is_pressing = false
	game_state = GameState.PLAYER_TURN

func show_settings():
	simulate_action("menu") 
	#TODO: rework this to signal? or make settings canvas a child of topPanel?

func simulate_action(action_name: String):
	var event:InputEventAction = InputEventAction.new()
	event.action = action_name
	event.pressed = true
	Input.parse_input_event(event)

func change_game_state(new_state: GameState):
	if (new_state == GameState.RESTORE):
		pass #TODO: get saved previous game state and restore it
	else:
		game_state = new_state
	print("GameState changed! current state:%s" % game_state)

