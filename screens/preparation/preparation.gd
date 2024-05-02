extends CanvasLayer
class_name PreparationScreen

@onready var _team_panel: PreparationScreenTeamPanel = %TeamPanel
@onready var _combatant_details: PreparationScreenCombatantDetails = %CombatantDetails
@onready var _combatants_for_sale: PreparationScreenCombatantsForSale = %CombatantsForSale
@onready var _enemy_team: PreparationScreenEnemyTeam = %EnemyTeam

func initialize(team: Team, enemy_team: Team) -> void:
	_team_panel.combatant_selected.connect(func(combatant: Combatant):
		_combatant_details.initialize(combatant)
	)
	_team_panel.initialize(team)
	_combatants_for_sale.initialize(team)
	_enemy_team.initialize(enemy_team)
