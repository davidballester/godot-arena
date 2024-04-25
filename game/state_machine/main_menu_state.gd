extends GameState
class_name GameMainMenuState

static func get_state_name() -> String:
	return "GameMainMenuState"
	
var _main_menu: MainMenuController

func _init() -> void:
	_main_menu = load("res://screens/main_menu/controller/main_menu_controller.tscn").instantiate()
	_main_menu.team_created.connect(
		func(team: Team): 
			controller.player_team = team
			state_machine.transition_to_state(GameBattleState.get_state_name()),
		CONNECT_ONE_SHOT
	)

func enter(_args: Array) -> void:
	controller.display_menu(_main_menu)
	
func exit() -> void:
	controller.hide_current_menu()
