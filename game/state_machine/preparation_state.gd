extends GameState
class_name GamePreparationState

const PREPARATION_SCREEN_RESOURCE = preload("res://screens/preparation/preparation.tscn")

static func get_state_name() -> String:
	return "GamePreparationState"
	
var _preparation_screen: PreparationScreen

func enter(_args: Array) -> void:
	_preparation_screen = PREPARATION_SCREEN_RESOURCE.instantiate()
	_preparation_screen.ready.connect(func(): _preparation_screen.initialize())
	_preparation_screen.battle_started.connect(func():
		state_machine.transition_to_state(GameBattleState.get_state_name())
	)
	controller.display_screen(_preparation_screen)
	
func exit() -> void:
	controller.hide_current_screen()
	_preparation_screen.queue_free()
