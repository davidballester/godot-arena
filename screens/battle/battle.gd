extends CanvasLayer
class_name BattleScreen

@onready var _player_team_score: BattleScreenTeamScore = %PlayerTeamScore
@onready var _enemy_team_score: BattleScreenTeamScore = %EnemyTeamScore
@onready var _player_team_panel: BattleScreenTeamPanel = %PlayerTeamPanel
@onready var _enemy_team_panel: BattleScreenTeamPanel = %EnemyTeamPanel

func _ready() -> void:
	add_child(GameGlobals.battle.terrain)
	move_child(GameGlobals.battle.terrain, 0)
	_player_team_score.initialize(GameGlobals.player_team)
	_enemy_team_score.initialize(GameGlobals.enemy_team)
	_player_team_panel.initialize(GameGlobals.player_team)
	_player_team_panel.hide()
	_enemy_team_panel.initialize(GameGlobals.enemy_team)
	_enemy_team_panel.hide()
	_player_team_score.team_clicked.connect(func():
		_player_team_panel.visible = not _player_team_panel.visible
	)
	_enemy_team_score.team_clicked.connect(func():
		_enemy_team_panel.visible = not _enemy_team_panel.visible
	)
