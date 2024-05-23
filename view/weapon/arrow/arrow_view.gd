extends Sprite2D
class_name ArrowView

const FADE_DURATION_SECONDS = 0.25

func initialize(attack: Attack, time_seconds: float) -> void:
	await _move(attack.target_global_position, time_seconds)
	await _fade(0.0)
	queue_free()
	
func _fade(alpha: float) -> void:
	await get_tree().create_tween().tween_property(
		self, 
		"modulate:a", 
		alpha, 
		FADE_DURATION_SECONDS
	).finished
	
func _move(final_position: Vector2, time_seconds: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, 
		"global_position", 
		final_position, 
		time_seconds,
	)
	await tween.finished
