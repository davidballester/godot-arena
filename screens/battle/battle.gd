extends CanvasLayer
class_name BattleScreen

func _ready() -> void:
	add_child(GameGlobals.battle.terrain)
	move_child(GameGlobals.battle.terrain, 0)
	GameGlobals.battle.terrain.add_child_on_ground(GameGlobals.player_team)
	GameGlobals.battle.terrain.add_child_on_ground(GameGlobals.enemy_team)
