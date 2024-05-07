extends StateMachine
class_name CombatantControllerStateMachine

@export var controller: CombatantController

func initialize() -> void:
	super.initialize()
	id = controller.id + "_controller_state_machine"
	for child in get_children():
		if child is CombatantControllerState:
			child.controller = controller
