extends Node2D
class_name BattleScreenController

@onready var _state_machine: BattleScreenStateMachine = %StateMachine

var player_team: Team
var _current_screen: Node

func initialize(player_team: Team) -> void:
	self.player_team = player_team
	_state_machine.initialize()

func display_screen(screen: Node) -> void:
	if _current_screen:
		hide_current_screen()
	add_child(screen)
	_current_screen = screen
	
func hide_current_screen() -> void:
	if not _current_screen:
		return
	_current_screen.queue_free()
	_current_screen = null
	
