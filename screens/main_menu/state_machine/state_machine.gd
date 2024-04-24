extends StateMachine
class_name MainMenuStateMachine

@export var controller: MainMenuController

func initialize() -> void:
	super.initialize()
	class_to_state.values().map(func(state: MainMenuState):
		state.controller = controller
	)
	transition_to_state(MainMenuInitialState.get_state_name())
