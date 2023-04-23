extends Node

var health: int
var max_hp: int

signal health_changed(health: int)

func _ready():
	max_hp = 5
	health = max_hp

func lose_hp(hp: int):
	health -= hp
	if (health <= 0):
		health = 0
		#game_over
	print("health lost! hp:%d" % health)
	emit_signal("health_changed", health)


func gain_hp(hp: int):
	health += hp
	if (health >= max_hp):
		health = max_hp
	print("health gained! hp:%d" % health)
	emit_signal("health_changed", health)

