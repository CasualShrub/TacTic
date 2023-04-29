extends Node2D

@onready var Animator = $AnimationPlayer

func _ready():
	Animator.play("idle")
	GameManager.player_position = self.global_position
	EventManager.player_damaged.connect(animate_take_damage)
	EventManager.card_picked_up.connect(animate_player_attacking)
	EventManager.card_drag_fail.connect(animate_player_idle)
	EventManager.card_drag_success.connect(animate_player_idle)

func animate_player_idle(_unused = null):
	Animator.play("idle")

func animate_player_attacking(_unused = null):
	Animator.play("attack")

func animate_take_damage():
	Animator.play("hurt")
	Animator.queue("idle")
	
	#TODO: Consider refactoring to use animator instead of tween?
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", (self.position + Vector2(1,0)), 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "position", (self.position + Vector2(-1,0)), 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(self, "position", (self.position + Vector2(0,0)), 0.2).set_trans(Tween.TRANS_ELASTIC)
