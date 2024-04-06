extends StateMachine
class_name CombatantControllerStateMachine

func initialize(controller: CombatantController) -> void:
	id = controller.id + "_controller_state_machine"
	for child in get_children():
		if child is CombatantControllerState:
			child.controller = controller
