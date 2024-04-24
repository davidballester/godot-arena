extends Node
class_name GameController

@onready var state_machine: GameStateMachine = %StateMachine

var _current_menu: Node

func _ready() -> void:
	state_machine.id = "Game"
	state_machine.initialize()
			
func _exit_tree() -> void:
	GameGlobals.exit()

func display_menu(menu: Node) -> void:
	if _current_menu:
		hide_current_menu()
	_current_menu = menu
	add_child(_current_menu)
	
func hide_current_menu() -> void:
	_current_menu.queue_free()
	_current_menu = null
	
