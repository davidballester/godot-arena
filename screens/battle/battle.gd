extends CanvasLayer
class_name BattleScreen

@onready var _player_team_score: BattleScreenTeamScore = %PlayerTeamScore
@onready var _enemy_team_score: BattleScreenTeamScore = %EnemyTeamScore
@onready var _player_team_panel: BattleScreenTeamPanel = %PlayerTeamPanel
@onready var _enemy_team_panel: BattleScreenTeamPanel = %EnemyTeamPanel
@onready var _player_combatant_details: BattleScreenCombatantDetails = %PlayerCombatantDetails
@onready var _enemy_combatant_details: BattleScreenCombatantDetails = %EnemyCombatantDetails

func _ready() -> void:
	add_child(GameGlobals.battle.terrain)
	move_child(GameGlobals.battle.terrain, 0)
	_player_team_panel.initialize(GameGlobals.player_team)
	_player_team_panel.hide()
	_player_combatant_details.hide()
	_player_team_panel.combatant_selected.connect(func(combatant: Combatant):
		_player_combatant_details.initialize(combatant)
		_player_combatant_details.show()
	)
	_enemy_team_panel.initialize(GameGlobals.enemy_team)
	_enemy_team_panel.hide()
	_enemy_combatant_details.hide()
	_enemy_team_panel.combatant_selected.connect(func(combatant: Combatant):
		_enemy_combatant_details.initialize(combatant)
		_enemy_combatant_details.show()
	)
	_player_team_score.initialize(GameGlobals.player_team)
	_player_team_score.team_clicked.connect(func():
		if not _player_combatant_details.visible:
			_player_team_panel.visible = not _player_team_panel.visible
			return
		_player_combatant_details.hide()
		_player_team_panel.visible = true
	)
	_enemy_team_score.initialize(GameGlobals.enemy_team)
	_enemy_team_score.team_clicked.connect(func():
		if not _enemy_combatant_details.visible:
			_enemy_team_panel.visible = not _enemy_team_panel.visible
			return
		_enemy_combatant_details.hide()
		_enemy_team_panel.visible = true
	)
