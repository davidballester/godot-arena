extends MainMenuState
class_name MainMenuTeamCreationState

static var team_creation_resource = preload(
	"res://screens/main_menu/views/team_creation/team_creation.tscn"
)

static func get_state_name() -> String:
	return "MainMenuTeamCreationState"

func enter(_args: Array) -> void:
	var team_creation_view: MainMenuTeamCreationView = team_creation_resource.instantiate()
	controller.display_menu(team_creation_view)
	team_creation_view.team_created.connect(_start_game, CONNECT_ONE_SHOT)
	team_creation_view.close_clicked.connect(_go_to_initial, CONNECT_ONE_SHOT)
	
func exit() -> void:
	controller.stop_displaying_menu()
	
func _start_game(team: Team) -> void:
	print("XXX", team)
	
func _go_to_initial() -> void:
	state_machine.transition_to_state(MainMenuInitialState.get_state_name())
