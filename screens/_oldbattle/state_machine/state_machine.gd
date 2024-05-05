extends StateMachine
class_name BattleScreenStateMachine

@export var controller: BattleScreenController

func initialize() -> void:
	super.initialize()
	class_to_state.values().map(func(state: BattleScreenState):
		state.controller = controller
	)
	transition_to_state(BattleScreenPreparationState.get_state_name())
