extends CombatantControllerState
class_name CombatantControllerHitState

static func get_state_name() -> String:
	return "CombatantControllerHitState"

func enter(args: Array) -> void:
	var damage = args[0]
	state_machine.controller.view.hit(damage)
