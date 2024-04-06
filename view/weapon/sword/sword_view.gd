extends WeaponView
class_name SwordView

const ATTACKS = ["swing", "thrust"]

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func attack() -> Signal:
	var random_attack = ATTACKS.pick_random()
	animation = random_attack
	animation_player.current_animation = random_attack
	animation_player.play()
	play()
	return animation_finished
