extends AnimatedSprite2D
class_name CombatantView

func initialize() -> void:
	idle()
	
func idle() -> Signal:
	return _play_animation("idle")

func die() -> Signal:
	return _play_animation("death")
	
func hit() -> Signal:
	await _play_animation("hit")
	return _play_animation("idle")
	
func roll() -> Signal:
	await _play_animation("roll")
	return _play_animation("idle")
	
func start_running() -> Signal:
	return _play_animation("run")
	
func stop_running() -> Signal:
	return _play_animation("idle")
	
func turn() -> Signal:
	await _play_animation("turn")
	return _play_animation("idle")
	
func _play_animation(animation_name: String) -> Signal:
	animation = animation_name
	play()
	return animation_finished
