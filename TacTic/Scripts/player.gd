extends Node2D

@onready var Animator = $AnimationPlayer

func _ready():
	Animator.play("idle")
	GameManager.player_position = self.global_position
	EventManager.player_damaged.connect(on_player_damaged)

func on_player_damaged():
	Animator.play("hurt")
	Animator.queue("idle")
	
	#TODO: Consider refactoring to use animator instead of tween?
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", (self.position + Vector2(1,0)), 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "position", (self.position + Vector2(-1,0)), 0.2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(self, "position", (self.position + Vector2(0,0)), 0.2).set_trans(Tween.TRANS_ELASTIC)
