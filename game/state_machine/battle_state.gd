extends GameState
class_name GameBattleState

const BATTLE_SCREEN_SCENE = preload("res://screens/battle/battle.tscn")

static func get_state_name() -> String:
	return "GameBattleState"
	
var _battle_screen: BattleScreen

func enter(_args: Array) -> void:
	_battle_screen = BATTLE_SCREEN_SCENE.instantiate()
	controller.display_screen(_battle_screen)
	_battle_screen.initialize()
	
func exit() -> void:
	controller.hide_current_battle_screen()
	_battle_screen.queue_free()
