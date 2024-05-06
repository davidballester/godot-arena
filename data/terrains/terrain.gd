extends Node
class_name Terrain

@onready var _battle_controller_container: Node = %BattleControllerContainer

func add_child_on_ground(child: Node) -> void:
	_battle_controller_container.add_child(child)
