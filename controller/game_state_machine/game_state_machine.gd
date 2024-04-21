extends StateMachine
class_name GameStateMachine

@export var game_controller: GameController

func _ready() -> void:
	for child in get_children():
		if not child is GameState:
			continue
		var state: GameState = child
		state.game_controller = game_controller
	transition_to_state(GameBattleState.get_state_name())
