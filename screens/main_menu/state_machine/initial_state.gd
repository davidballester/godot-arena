extends MainMenuState
class_name MainMenuInitialState

static var initial_menu_resource = preload(
	"res://screens/main_menu/views/initial/initial.tscn"
)

static func get_state_name() -> String:
	return "MainMenuInitialState"
	
func enter(_args: Array) -> void:
	var initial_menu: MainMenuInitialView = initial_menu_resource.instantiate()
	controller.display_menu(initial_menu)
	initial_menu.new_game_clicked.connect(_on_new_game_clicked, CONNECT_ONE_SHOT)
	
func exit() -> void:
	controller.stop_displaying_menu()
	
func _on_new_game_clicked() -> void:
	state_machine.transition_to_state(MainMenuTeamCreationState.get_state_name())
