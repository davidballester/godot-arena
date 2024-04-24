extends GameState
class_name GameMainMenuState

static func get_state_name() -> String:
	return "GameMainMenuState"
	
var _main_menu: MainMenuController

func _init() -> void:
	_main_menu = load("res://screens/main_menu/controller/main_menu_controller.tscn").instantiate()

func enter(_args: Array) -> void:
	game_controller.display_menu(_main_menu)
	_main_menu.start()
	
func exit() -> void:
	game_controller.hide_current_menu()
	_main_menu.stop()
