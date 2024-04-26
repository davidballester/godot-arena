extends GameState
class_name GameBattleState

const BATTTLE_CONTROLLER_RESOURCE = preload("res://screens/battle/controller/battle.tscn")

static func get_state_name() -> String:
	return "GameBattleState"
	
var _battle_screen_controller: BattleScreenController

func enter(_args: Array) -> void:
	_battle_screen_controller = BATTTLE_CONTROLLER_RESOURCE.instantiate()
	controller.display_battle_screen(_battle_screen_controller)
	_battle_screen_controller.initialize(controller.player_team)
	
func exit() -> void:
	controller.hide_current_battle_screen()
	_battle_screen_controller.queue_free()
