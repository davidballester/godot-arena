extends GameState
class_name GameMainMenuState

static func get_state_name() -> String:
	return "GameMainMenuState"
	
var _main_menu: MainMenuController

func _init() -> void:
	_main_menu = load("res://screens/main_menu/main_menu.tscn").instantiate()
	_main_menu.new_game_started.connect(
		func(): 
			controller.start_new_game()
			state_machine.transition_to_state(GamePreparationState.get_state_name()),
		CONNECT_ONE_SHOT
	)

func enter(_args: Array) -> void:
	controller.display_screen(_main_menu)
	
func exit() -> void:
	controller.hide_current_screen()
