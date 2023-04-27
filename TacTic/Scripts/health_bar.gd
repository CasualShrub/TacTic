class_name HealthBar
extends Node2D

var bar_array: Array[AnimatedSprite2D]
var target #target can be player or enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_child_count():
		bar_array.append(get_node("%d" % (i+1)))
	PlayerManager.health_changed.connect(Callable(self, "update_HealthBar"))

func update_HealthBar(health: int):
	for i in bar_array.size():
		if((i+1) > health):
			bar_array[i].visible = false
		else:
			bar_array[i].visible = true
