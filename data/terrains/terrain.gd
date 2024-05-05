extends Node
class_name Terrain

@onready var _battle_controller_container: Node = %BattleControllerContainer

func add_battle_controller(battle_controller: BattleController) -> void:
	_battle_controller_container.add_child(battle_controller)
