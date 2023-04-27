class_name Projectile
extends Node2D

var target_position: Vector2

func _ready():
	target_position = GameManager.player_position
	target_position = self.to_local(target_position)

func animate_to_target():
	var tween: Tween = create_tween()
	tween.parallel().tween_property(self, "position", target_position, 0.6).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(Callable(EventManager, "emit_player_damaged"))
	tween.tween_callback(self.queue_free)
