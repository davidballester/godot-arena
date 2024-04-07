extends CombatantControllerState
class_name CombatantControllerDeadState

const DISSAPEAR_WEAPON_DELAY_S: float = 0.5

static func get_state_name() -> String:
	return "CombatantControllerDeadState"

func enter(_args: Array) -> void:
	controller.view.die()
	get_tree().create_timer(DISSAPEAR_WEAPON_DELAY_S).timeout.connect(func():
		controller.weapon_view.dissapear()
	)
