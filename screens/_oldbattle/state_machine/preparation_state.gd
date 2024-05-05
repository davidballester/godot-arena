extends BattleScreenState
class_name BattleScreenPreparationState

const PREPARATION_RESOURCE = preload("res://screens/battle/views/preparation/battle_preparation.tscn")

static func get_state_name() -> String:
	return "BattleScreenPreparationState"

func enter(_args: Array) -> void:
	var preparation = PREPARATION_RESOURCE.instantiate()
	controller.display_screen(preparation)
	preparation.initialize(controller.player_team)
