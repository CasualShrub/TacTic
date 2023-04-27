class_name Enemy
extends Node2D

func _ready():
	GameManager.enemy_position = self.global_position
	print(GameManager.enemy_position)
