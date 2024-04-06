extends CombatantControllerState
class_name CombatantControllerHitState

static func get_state_name() -> String:
	return "CombatantControllerHitState"

func enter(_args: Array) -> void:
	controller.view.hit()
