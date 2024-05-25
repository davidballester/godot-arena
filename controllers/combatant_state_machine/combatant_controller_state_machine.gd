extends StateMachine
class_name CombatantControllerStateMachine

@export var controller: CombatantController

func initialize() -> void:
	id = controller.id + "_controller_state_machine"
	super.initialize()
