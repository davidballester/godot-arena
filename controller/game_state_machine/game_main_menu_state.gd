extends GameState
class_name GameMainMenuState

var _main_menu: MainMenu

func _init() -> void:
	_main_menu = load("res://view/main_menu/main_menu.tscn").instantiate()

static func get_state_name() -> String:
	return "GameMainMenuState"

func enter(_args: Array) -> void:
	game_controller.display_menu(_main_menu)
	_main_menu.start()
	
func exit() -> void:
	game_controller.hide_current_menu()
	_main_menu.stop()
