extends CanvasLayer
class_name BattleScreen

func _ready() -> void:
	add_child(GameGlobals.battle.terrain)
	move_child(GameGlobals.battle.terrain, 0)
