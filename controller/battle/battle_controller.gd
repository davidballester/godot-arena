extends Node
class_name BattleController

static var team_colors = [
	Color.from_string("#f77622", Color.DARK_RED),
	Color.from_string("#ff0044", Color.DARK_RED)
]

@onready var _hud: HUD = %HUD

var _battle: Battle
var _id_to_team: Dictionary
var _id_to_combatant: Dictionary
var _weapons_data: WeaponsData
var _combatants_templates_data: CombatantsTemplatesData
var _teams_data: TeamsData
var _database: SQLite

func _ready() -> void:
	_database = SQLController.get_database()
	_database.open_db()
	_weapons_data = WeaponsData.new(_database)
	var combatants_names_data = CombatantsNamesData.new(_database)
	_combatants_templates_data = CombatantsTemplatesData.new(
		_database,
		combatants_names_data,
	)
	_teams_data = TeamsData.new(_database)
	_battle = Battle.new()
	for child in get_children():
		if not child is Team:
			continue
		var team: Team = child
		remove_child(team)
		add_team(team)
		
func initialize() -> void:
	var first_team_id = _id_to_team.keys()[0]
	var first_team = _id_to_team.get(first_team_id)
	var second_team_id = _id_to_team.keys()[1]
	var second_team = _id_to_team.get(second_team_id)
	_hud.initialize(first_team, second_team)
			
func _exit_tree() -> void:
	_database.close_db()
			
func _physics_process(_delta: float) -> void:
	var combatants: Array = _id_to_combatant.values()
	combatants.sort_custom(func(c0: CombatantController, c1: CombatantController):
		return c0.global_position.y < c1.global_position.y
	)
	for i in range(0, combatants.size()):
		var combatant: CombatantController = combatants[i]
		combatant.z_index = i
	
func add_team(team: Team) -> void:
	team.id = _teams_data.get_random_team_name()
	_id_to_team[team.id] = team
	var teams_count = _id_to_team.keys().size()
	team.color = team_colors[teams_count % team_colors.size()]
	team.icon = _teams_data.get_random_icon()
	add_child(team)
	
func add_combatant(
	team_id: String,
) -> CombatantController:
	var team: Team = _id_to_team[team_id]
	var combatant_type = _combatants_templates_data.get_random_type()
	var weapon = _weapons_data.get_random_weapon()
	var combatant = _combatants_templates_data.create_random_combatant(
		team,
		combatant_type,
		_battle,
		weapon
	)
	_id_to_combatant[combatant.id] = combatant
	return combatant

func get_teams_ids() -> Array:
	return _id_to_team.keys()
