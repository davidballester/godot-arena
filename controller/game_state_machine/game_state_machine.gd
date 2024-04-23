extends StateMachine
class_name GameStateMachine

@export var game_controller: GameController

func initialize() -> void:
	super.initialize()
	for state: GameState in class_to_state.values():
		state.game_controller = game_controller
	transition_to_state(GameMainMenuState.get_state_name())
