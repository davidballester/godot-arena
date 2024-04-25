extends StateMachine
class_name GameStateMachine

@export var controller: GameController

func initialize() -> void:
	super.initialize()
	for state: GameState in class_to_state.values():
		state.controller = controller
	transition_to_state(GameMainMenuState.get_state_name())
