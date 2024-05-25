extends CombatantControllerState
class_name CombatantControllerIdleState

static func get_state_name() -> String:
	return "CombatantControllerIdleState"

func enter(_args: Array) -> void:
	state_machine.controller.view.idle()
