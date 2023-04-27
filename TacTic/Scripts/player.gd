extends Node2D

@onready var Animator = $AnimationPlayer

func _ready():
	Animator.play("idle")
	GameManager.player_position = self.global_position
	EventManager.player_damaged.connect(on_player_damaged)

func on_player_damaged():
	Animator.play("hurt")
	Animator.queue("idle")
