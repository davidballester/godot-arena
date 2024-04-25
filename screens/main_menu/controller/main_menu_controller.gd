extends CanvasLayer
class_name MainMenuController

signal team_created(Team)

@onready var _current_menu_container: Control = %CurrentMenuContainer
@onready var _state_machine: MainMenuStateMachine = %StateMachine

func _ready() -> void:
	_state_machine.initialize()

func display_menu(menu: Node) -> void:
	_current_menu_container.add_child(menu)
	
func stop_displaying_menu() -> void:
	_current_menu_container.get_children().map(func(child: Node): 
		child.queue_free()
	)

func set_team(team: Team) -> void:
	team_created.emit(team)
