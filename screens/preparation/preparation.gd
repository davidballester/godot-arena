extends CanvasLayer
class_name PreparationScreen

signal battle_started()

@onready var _team_panel: PreparationScreenTeamPanel = %TeamPanel
@onready var _combatant_details: PreparationScreenCombatantDetails = %CombatantDetails
@onready var _combatants_for_sale: PreparationScreenCombatantsForSale = %CombatantsForSale
@onready var _enemy_team: PreparationScreenEnemyTeam = %EnemyTeam
@onready var _start_battle: StyledButton = %StartBattle

func initialize() -> void:
	_team_panel.combatant_selected.connect(func(combatant: Combatant):
		_combatant_details.initialize(combatant, GameGlobals.player_team.combatants.size() > 1)
	)
	_team_panel.initialize()
	_combatants_for_sale.initialize()
	_combatants_for_sale.combatant_bought.connect(func(combatant: Combatant):
		GameGlobals.player_team.add_combatant(combatant)
		_team_panel.add_combatant(combatant)
	)
	_enemy_team.initialize()
	_combatant_details.combatant_sold.connect(func(combatant: Combatant):
		GameGlobals.player_team.remove_combatant(combatant)
		_team_panel.remove_combatant(combatant)
		combatant.queue_free()
	)
	_start_battle.pressed.connect(func():
		GameGlobals.get_teams_data().mark_team_icon_path_as_used(
			GameGlobals.player_team.icon.resource_path
		)
		GameGlobals.get_teams_data().mark_team_name_as_used(
			GameGlobals.player_team.team_name
		)
		battle_started.emit()
	)
