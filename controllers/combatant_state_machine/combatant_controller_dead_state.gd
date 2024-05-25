extends CombatantControllerState
class_name CombatantControllerDeadState

static func get_state_name() -> String:
	return "CombatantControllerDeadState"

func enter(_args: Array) -> void:
	state_machine.controller.die()
